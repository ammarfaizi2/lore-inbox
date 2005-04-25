Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVDYDmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVDYDmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVDYDmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:42:16 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:10368 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262508AbVDYDmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:42:09 -0400
Date: Mon, 25 Apr 2005 04:40:26 +0100 (IST)
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
In-Reply-To: <Pine.LNX.4.62.0504250413200.14200@sheen.jakma.org>
Message-ID: <Pine.LNX.4.62.0504250435050.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <426C5F43.8010705@dwheeler.com>
 <Pine.LNX.4.62.0504250413200.14200@sheen.jakma.org>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Paul Jakma wrote:

> You dont even need it, see my other mail. If:
>
> - the signature is an object and added after the commit object
>
> - tools know that signatures are 'proxies of' or precursors to the
>  objects they are signing (which makes sense, a signature by
>  definition refers to something else)
>
> - the signature object refers to the object it is signing (eg a
>  'Signing <object ID>' header)
>
> Then head can simply be the signature object and tools can find the 
> commit by following the 'Signing' field of the signature (they dont 
> even need to check the signature is valid). No index lookup needed.

> You only need the index for historical verification really, and you can 
> always generate an index if needs be. (and have the tools maintain it).

Uh, I have no idea whether verifying a signature of a commit object 
is sufficient, ie equivalent to signing each file.

commit refers to tree objects, which I presume lists the SHA-1 object 
IDs of files, but IIRC Linus already described why a signature of the 
commit object should not be used to trust the rest of commit.. (i'll 
have to find his mail). If so, an index is required.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Old programmers never die, they just hit account block limit.
