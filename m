Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSKVOxz>; Fri, 22 Nov 2002 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbSKVOxz>; Fri, 22 Nov 2002 09:53:55 -0500
Received: from host194.steeleye.com ([66.206.164.34]:13583 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264889AbSKVOxx>; Fri, 22 Nov 2002 09:53:53 -0500
Message-Id: <200211221500.gAMF0lh02117@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup 
In-Reply-To: Message from "Martin J. Bligh" <mbligh@aracnet.com> 
   of "Thu, 21 Nov 2002 10:35:43 PST." <228760000.1037903743@flay> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Nov 2002 09:00:47 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbligh@aracnet.com said:
> > Why do you need to move the .h files?
> Because they're in a silly place now. They should be whereever all the
> other include files are.

> > CFLAGS += -Iarch/i386/$(MACHINE_H) -Iarch/i386/mach-generic
> > That should achieve the same effect?

> Header files go under include .... 

That's not necessarily true.  Externally useful header files go in include.  
Header files only used internally to the subsystem go in local directories.

The reason I put them under arch/i386 is because I didn't want the guts of the 
subarch splitup spilling into the kernel core.

While the subarch is local to i386, I think the headers should stay there.  If 
you want to make the subarch a global framework (and thus get agreement with 
Russel and ARM to use it) then putting them under the global include 
directories would probably make sense.

James


