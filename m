Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVGFLvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVGFLvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 07:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVGFLru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 07:47:50 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:58824 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262243AbVGFJCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:02:16 -0400
Message-ID: <42CB9E18.8080206@namesys.com>
Date: Wed, 06 Jul 2005 02:02:16 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Jonathan Briggs <jbriggs@esoft.com>, Ross Biro <ross.biro@gmail.com>,
       Hubert Chan <hubert@uhoreg.ca>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca> <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <87hdfgvqvl.fsf@evinrude.uhoreg.ca> <8783be6605062914341bcff7cb@mail.gmail.com> <42C3615A.9020600@namesys.com> <20050705154624.GC15652@admingilde.org> <1120602720.27600.79.camel@localhost> <20050706072059.GE15652@admingilde.org>
In-Reply-To: <20050706072059.GE15652@admingilde.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:

>hoi :)
>
>On Tue, Jul 05, 2005 at 04:32:00PM -0600, Jonathan Briggs wrote:
>  
>
>>You could do filesystems in userspace too and just use the kernel's
>>block layer.
>>    
>>
>
>but you can't do that in an library, you have to use a filesystem
>server in order to get access control.
>But you can build a library that handles uniform access to
>files and directories.
>
>Don't get me wrong, I'm all for a uniform interface for files and
>metadata, but I don't think that it has to be in the kernel.
>Gnome and KDE already have their own userspace VFS, something
>like that should be used.
>
>One has to distinguish between the low-level filesystem and
>the storage system which is presented to the user.
>
>  
>
Yes, but to do what you advocate properly, the existing semantics
currently in the kernel should be moved out of it into user space.

I think the exokernel approach by Frans is a very interesting approach. 
I wish I had the experience with it necessary to know if it was
effective.  I do NOT take the position that name resolution should be in
the kernel.  I DO take the position that it should be either in the
kernel or out of the kernel, and should constitute one cohesive and
coherent body of code.  If someone talks Linus into trying the exokernel
approach, I will be happy to educate myself to where I have an opinion
on whether that works.  It is easy to see powerful advantages to the
exokernel approach: I wish I understood the security model for it, and I
wish I was sure that name resolution would not require too many context
switches as one fetches each storage component required by a name
resolution.

Masover's words about HURD earlier in this thread were very well said. 
Context switching is expensive, and I find it easier to be sure my code
will both perform well and be cohesive if it is all done in the kernel
by one body of code.
