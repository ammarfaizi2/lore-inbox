Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWECJZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWECJZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWECJZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:25:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:44753 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S965133AbWECJZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:25:25 -0400
Date: Mon, 1 May 2006 20:56:17 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/4] MultiAdmin LSM
Message-ID: <20060501205617.GA4645@ucw.cz>
References: <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr> <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr> <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Subject: [PATCH 0/4] MultiAdmin LSM
>          (was: Re: Time to remove LSM
>          (was: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks))
> 
> 
> 0. Preface
> ==========
> Thanks to Greg who, requiring me to post more-split patches, made me
> reconsider the code. I did nothing less than to simplified the whole patch
> cruft (shrunk by factor 10) and removed what seemed unreasonable. This
> thread posts MultiAdmin *1.0.5*.
> 
> 
> 
> 1. Super-short description
> ==========================
> Three user classes exist (determined by user-defined UID ranges),
>     - superadmin, the usual "root"
>     - subadmin
>     - normal users
> 
> A usual (non-multiadm,non-selinux) system has only one superadmin (UID 0)
> and a number of normal users, and the superadmin can operate on
> everything.
> 
> The "subadmin" can read in some superadmin-only places, and is allowed to
> fully operate on processes/files/ipc/etc. of normal users. The full list
> (possibly incomplete) of permissions is available in the README.txt
> (includes short description) in the out-of-tree tarball.
> [http://freshmeat.net/p/multiadm/]

I guess you should really split CAP_SYS_ADMIN into some subsets that
make sense... along with explanation why subsets are 'right'.

							Pavel
-- 
Thanks, Sharp!
