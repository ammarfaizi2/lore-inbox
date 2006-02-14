Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWBNEwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWBNEwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWBNEwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:52:49 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:13936 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1030346AbWBNEwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:52:49 -0500
Message-ID: <43F1621D.1060401@suse.com>
Date: Mon, 13 Feb 2006 23:52:45 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "Kevin O'Connor" <kevin@koconnor.net>, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, jmorris@namei.org
Subject: Re: Size-128 slab leak
References: <20060131024928.GA11395@double.lan>	 <20060201231001.0ca96bf0.akpm@osdl.org>  <20060203040018.GA3757@double.lan> <1138972872.18268.327.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138972872.18268.327.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> BTW, Jeff - I assume you know about the unrelated breakage in
> SELinux/reiserfs support that was introduced by the changes for atomic
> security labeling of inodes in 2.6.14.  If you care, you might want to
> use the same workaround upstreamed for xfs for 2.6.16.  But I understand
> that SELinux is not a priority in SuSE presently.

Hi Stephen -

Thanks for the reminder on this one. I have a series of patches that
rework the reiserfs xattr implementation. One of the patches adds
journalling for xattrs, including putting the inherited ACLs in the same
transaction as the object creation. Adding the SELinux attribute to the
same transaction wouldn't be too much of a problem.

I should have a patch tomorrow, though it will depend on the xattr patchset.

-Jeff

--
Jeff Mahoney
SUSE Labs
