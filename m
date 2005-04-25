Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVDYBst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVDYBst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 21:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVDYBst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 21:48:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:12933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262422AbVDYBsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 21:48:45 -0400
Date: Sun, 24 Apr 2005 18:50:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David A. Wheeler" <dwheeler@dwheeler.com>
cc: Paul Jakma <paul@clubi.ie>, Sean <seanlkml@sympatico.ca>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
In-Reply-To: <426C4168.6030008@dwheeler.com>
Message-ID: <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Apr 2005, David A. Wheeler wrote:
> 
> It may be better to have them as simple detached signatures, which are
> completely separate files (see gpg --detached).
> Yeah, gpg currently implements detached signatures
> by repeating what gets signed, which is unfortunate,
> but the _idea_ is the right one.

Actually, if we do totally separate files, then the detached thing is ok, 
and we migth decide to not call the objects at all, since that seems to be 
unnecessarily complex.

Maybe we'll just have signed tags by doing exactly that: just a collection 
of detached signature files. The question becomes one of how to name such 
things in a distributed tree. That is the thing that using an object for 
them would have solved very naturally.

		Linus
