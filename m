Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVAFUnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVAFUnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVAFUkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:40:47 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:25081 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S263039AbVAFUfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:35:42 -0500
Date: Thu, 06 Jan 2005 15:35:27 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
In-reply-to: <20050106191355.GA23345@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
Message-id: <41DDA10F.6010805@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050106190538.GB1618@us.ibm.com>
 <20050106191355.GA23345@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 11:05:38AM -0800, Paul E. McKenney wrote:
> 
>>Hello, Andrew,
>>
>>Some export-removal work causes breakage for an out-of-tree filesystem.
>>Could you please apply the attached patch to restore the exports for
>>files_lock and set_fs_root?
> 
> 
> What out of tree filesystem, and what the heck is it doing?
> 
> Without proper explanation it's vetoed.
> 
> btw, any reason you put half the world in the Cc list?  Al and Andrew I
> see, but do the other people on the Cc list have to do with it?  And you
> forgot the person that killed the export.

Well, autofsng patches (new set forthcoming) use set_fs_root/set_fs_pwd
to pivot a call_usermodehelper process into the triggering process's
namespace.

It has no need however for files_lock.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3aEPdQs4kOxk3/MRAlvmAJ4sXcg0Cx8+00WrNEkXW4T7Ji3tKwCfVYPO
43IFyNGeDo85sqDJCprLR8I=
=Vbec
-----END PGP SIGNATURE-----
