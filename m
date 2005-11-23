Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVKWErI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVKWErI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVKWErI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:47:08 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:43163 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932520AbVKWErH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:47:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=msbJAKJywPP6ErVq8ui83teLkjRLR8SyRwaw5YT1fFXbfvNmTGUPvf6/dnADSRtdS4UQsTqVzRjjI5S9/3+UWPZRVnldq66c1adP9PSFNmhJIcHo599F4Uj6IV+KXuErPPe8nX1GWARONA8FuzgIwhw0eLzSARM7OB33zs16XoI=
Message-ID: <35fb2e590511222047p7f074af6j52d139845794f640@mail.gmail.com>
Date: Wed, 23 Nov 2005 04:47:06 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Cc: cp@absolutedigital.net, linux-kernel@vger.kernel.org, jcm@jonmasters.org,
       torvalds@osdl.org, viro@ftp.linux.org.uk, hch@lst.de
In-Reply-To: <20051122141628.41f3134f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	 <20051116005958.25adcd4a.akpm@osdl.org>
	 <20051119034456.GA10526@apogee.jonmasters.org>
	 <20051121233131.793f0d04.akpm@osdl.org>
	 <35fb2e590511220356x75a951f1t8a36d0556a940751@mail.gmail.com>
	 <20051122141628.41f3134f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
> Jon Masters <jonmasters@gmail.com> wrote:

> > On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:

> > > That still does the wrong thing.  Put in a write-protected floppy, try to
> > > write to it and it says -EROFS.  Then pop the WP switch and try to
> > > write to it again and it wrongly claims EPERM.  A second attempt to
> > > write will succeed.

> > The problem is that we need to wait until the floppy driver next
> > checks the read status on the drive. I think to get it completely
> > right will take moving bits of the floppy driver around, unless I'm
> > being stupid. I'm planning to do that too though.

> In the meanwhile I think we should revert back to the 2.6.14 version of
> floppy.c - the present problem is probably worse than the one which it
> kinda-fixes.

Ok, as you please. It's probably going to take something much more
ugly to make this work with things as they stand - I'll get something
out at the weekend.

Jon.
