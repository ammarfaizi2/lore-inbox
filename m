Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946513AbWJSVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946513AbWJSVUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946510AbWJSVUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:20:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51966 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1946513AbWJSVUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:20:23 -0400
Date: Thu, 19 Oct 2006 23:16:30 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
cc: 7eggert@gmx.de, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org, kronos.it@gmail.com, ismail@pardus.org.tr
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
In-Reply-To: <4536b8dc.nfxUMeg8jVJ9WF95%Joerg.Schilling@fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.58.0610192256460.2316@be1.lrz>
References: <771eN-VK-9@gated-at.bofh.it> <771yn-1XU-65@gated-at.bofh.it>
 <E1GZy4L-00015O-AV@be1.lrz> <453644f3.0BzwxliMKAw+rSMj%Joerg.Schilling@fokus.fraunhofer.de>
 <Pine.LNX.4.58.0610182023100.2145@be1.lrz>
 <4536b8dc.nfxUMeg8jVJ9WF95%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Joerg Schilling wrote:
> Bodo Eggert <7eggert@gmx.de> wrote:
> > On Wed, 18 Oct 2006, Joerg Schilling wrote:
> > > Bodo Eggert <7eggert@elstempel.de> wrote:

> > > > BTW2, Just to be cautionous: what will happen if somebody forces the same
> > > > inode number on two different entries?
> >
> > [...]
> > > This is something you cannot check.
> >
> > Exactly that's why I'd ignore the on-disk "inode number" and instead use
> > the generated one untill someone comes along with a clever idea to fix
> > the issue or can show that it's mostly hermless.
> 
> I could understand you in case that Linux would do some basic consistency checks
> in the iso-9660 code already.....

ISO9660-over-NFS is no big usecase, linked files on CD aren't common and 
the current code just won't benefit from hardlinks. Therefore I don't see 
a compelling reason to use this feature without first thinking about 
possible attacks.

Even if there are more holes to be plugged, punching even more holes 
doesn't help. Instead, we should hope that someone finds the time to
plug these holes and praise him when he comes.

> Show me another program besides mkisofs that implements inode numbers _and_ does
> it wrong.

My hacked mkisofs, which I'll use to r00t you all and gain world domination.
-- 
"Don't draw fire; it irritates the people around you."
-Your Buddies
