Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288422AbSAQJ1O>; Thu, 17 Jan 2002 04:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288455AbSAQJ1E>; Thu, 17 Jan 2002 04:27:04 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:27923 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S288435AbSAQJ0x>; Thu, 17 Jan 2002 04:26:53 -0500
Date: Thu, 17 Jan 2002 10:26:51 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Message-ID: <20020117102650.A1742@devcon.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local> <20020116195105.C18039@devcon.net> <20020116230620.GE3410@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116230620.GE3410@kroah.com>; from greg@kroah.com on Wed, Jan 16, 2002 at 03:06:21PM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 03:06:21PM -0800, Greg KH wrote:
> > 
> > - It somewhat collides with the Linux Security Module project
> >   (http://lsm.immunix.org/).
> I don't see this conflicting with what the lsm patch does (with the
> minor exception of removing the capable() call.)  How do you see a
> conflict here?

I don't mean a conflict in the implementation. Clearly it is possible
to combine accessfs checks with LSM hooks (indeed, I think this is
the only possible way for accessfs until LSM gets authoritative
hooks - hey, this could be an example project for "authoritative"
advocates :-).

My concern was conceptual: accessfs is just another mechanism for
access control to various ressources. As I understand it, LSM is
intended to move /all/ access control logic into separate modules with
a uniform interface to the kernel, so that you can choose whatever
access control mechanism you want (or even rip out all access control,
as for example some embedded applications don't need it). Clearly it's
a long way until LSM actually gets to this point, but nevertheless
it's the overall goal of the whole effort IMHO.

Moving accessfs to use LSM hooks means only changes at the
implementation level, no changes of the concept or user interface of
accessfs are needed. What I wanted to express was only that the LSM
effort may put some constraints on the timeline for kernel inclusion
of accessfs ("collide" vs. "conflict" ;-).

> This patch looks nice, I like it.

I totally agree with that. Maybe I should have expressed it more
clearly in my first mail ;-)

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
