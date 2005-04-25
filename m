Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVDYDMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVDYDMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVDYDLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:11:36 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:47503 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262498AbVDYDIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:08:54 -0400
Date: Mon, 25 Apr 2005 04:08:39 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>
cc: Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
In-Reply-To: <Pine.LNX.4.62.0504250323040.14200@sheen.jakma.org>
Message-ID: <Pine.LNX.4.62.0504250405010.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.62.0504250212200.14200@sheen.jakma.org> <426C5266.6050200@dwheeler.com>
 <Pine.LNX.4.62.0504250323040.14200@sheen.jakma.org>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, to add to below..

If one wished, one could optionally store the actual signature data 
as a seperate blob object and refer to it in the signing object. Not 
needed really for a GPG ASCII clear-signed detached signature (tiny 
and they're ASCII obviously :) ), but who knows.

On Mon, 25 Apr 2005, Paul Jakma wrote:

> - add the 'signature object' to the respository after the signed
>  object
>
> So a 'signed commit' turns into the
>
> - tool preparing the commit object,
> 	- get the user to sign it
> 	- save the detached signature for later
> - adding the commit object to the repository

   - adding the signature blob, if it is to stored as a blob

> - prepare the signing object and add to repository

> The repository head then refers then to signature object, which could 
> (handwaving) look something like:
>
> 	Object		Signature
> 	Signing 	<object ID, in this case of the commit object>
> 	Sign-type 	GPG

With either a 'Signature  <ID of signature data blob>' or else:

> 	<signature data>


regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
May you have many beautiful and obedient daughters.
