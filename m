Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269594AbRHHWOR>; Wed, 8 Aug 2001 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269596AbRHHWOI>; Wed, 8 Aug 2001 18:14:08 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:9275 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S269594AbRHHWNw>; Wed, 8 Aug 2001 18:13:52 -0400
Date: Wed, 8 Aug 2001 17:14:00 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200108082214.RAA45834@tomcat.admin.navo.hpc.mil>
To: hpa@zytor.com, linux-kernel@vger.kernel.org, mikej@umem.com
Subject: Re: PCI NVRAM Memory Card
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com>:
> Followup to:  <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
> By author:    Mike Jadon <mikej@umem.com>
> In newsgroup: linux.dev.kernel
> >
> > My company has released a PCI NVRAM memory card but we haven't developed a 
> > Linux driver for it yet.  We want the driver to be open to developers to 
> > build upon.  Is there a specific path we should follow with this being our 
> > goal?  In researching Linux driver development I have come across "GPL" or 
> > "LGPL".  Where do you recommend we go to find out more about this 
> > development process?
> > 
> > Thanks and my apologies for using a technical forum for this question, but 
> > wanted to go to the right source.
> > 
> 
> Since you're willing to open the source, you are probably best off
> making the kernel portion of your driver GPL and submit it for
> integration into the main kernel tree.  The drivers included in the
> main kernel tree tend to be the ones that work reliably over time, and
> are therefore most valuable to your customers.
> 
> As someone else mentioned, user-space libraries should be LGPL.

Actually, the libraries only should be LGPL if you are still intending
to release the source to the library. You can use your own license if
they contain propriatary information, but you wish to allow other developers
to USE the library with new applications which may or may not be GPL.

It gets tricky to word the license such that you don't take over any license
used for the other applications that link with your propriatary library.

Applications can be GPL or propriatary with whatever license you choose.

Please check with real lawyers for the truly "right source".

> It should be pointed out that you, as the copyright holder, can
> "dual-license" the code if you want to use the same code for
> closed-source projects.  If so, the mention of the dual license nature
> should be specified in the open code, to keep you from getting in a
> sticky situation when someone submits patches.  The most formal such
> license is probably the MPL (Mozilla Public License); I do not know
> if MPL'd code would be considered "GPL compatible" and therefore
> eligible for inclusion in the main kernel.
> 
> Another possible license used in a few places is the "New BSD" license
> (as opposed to the "Old BSD" license, with the so-called "advertising
> clause".)  The BSD license allows *anyone* (including yourselves, of
> course, but also your competitors) to take the code and use it in a
> closed-source project.
> 
> 	-hpa

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
