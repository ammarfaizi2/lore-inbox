Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161245AbWASPwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161245AbWASPwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbWASPwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:52:49 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:36172 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1161245AbWASPwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:52:49 -0500
Message-ID: <43CFB6B1.8000908@suse.com>
Date: Thu, 19 Jan 2006 10:56:33 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Damien Wyart <damien.wyart@free.fr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 + reiser* from -rc1-mm1 : BUG with reiserfs
References: <20060118122631.GA12363@localhost.localdomain> <43CEC61E.2040500@suse.com> <200601190004.36549.rjw@sisk.pl> <43CECC7D.1090200@suse.com> <20060119094205.GA14907@localhost.localdomain>
In-Reply-To: <20060119094205.GA14907@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Damien Wyart wrote:
> Hello,
> 
>>>> Sigh. Ok. Back out the reiserfs patches
> * Jeff Mahoney <jeffm@suse.com> [2006-01-18 18:17]:
>> Just the on-demand bitmap stuff.
> 
> New test this morning with latest 2.6.16-rc1-git pulled with git, and
> all reiserfs and reiser4 patches from -rc1-mm1, EXCEPT the three
> on-demand bitmap for reiserfs. And when booting, the systems half
> crashes with this error. So I guess the bad patches are not only the
> ones for on-demand bitmap...

Indeed. What's happening here is that the SB_AP_BITMAP(s) macro is
evaluating to NULL since other places use it too early.

As I said, these patches should never have been sent out.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDz7axLPWxlyuTD7IRArQxAJ9d6gijEPjXxKnXcC5FNWUuT95eqACcDURU
HOTcl/BhvTd2RwAO4fd/ZZ0=
=Ct4w
-----END PGP SIGNATURE-----
