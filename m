Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSJ3UgJ>; Wed, 30 Oct 2002 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264893AbSJ3UgJ>; Wed, 30 Oct 2002 15:36:09 -0500
Received: from host194.steeleye.com ([66.206.164.34]:36359 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264889AbSJ3UgH>; Wed, 30 Oct 2002 15:36:07 -0500
Message-Id: <200210302042.g9UKgLS02419@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Steven Dake <sdake@mvista.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SCSI and FibreChannel Hotswap for linux 2.5.44-bk2 
In-Reply-To: Message from Steven Dake <sdake@mvista.com> 
   of "Wed, 30 Oct 2002 11:54:47 MST." <3DC02AF7.6020209@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 Oct 2002 15:42:21 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdake@mvista.com said:
>  This patch has been reviewed by Alan Cox, Greg KH, Christoph Hellwig,
>  Patrick Mansfield, Rob Landly, Jeff Garzik, Scott Murray, James
> Bottomley, Mike Anderson, Randy Dunlap and Patrick Mochel. 

Well, I reviewed it but my though was that it should be built on the emerging 
hotplug infrastructure.

I'm currently trying to move things like this into the user layer, so from a 
design principle I don't want to have 90% using the user space stuff and 10% 
using its in-kernel equivalent because that means we have two mechanisms to 
maintain, thus doubling the work.

The problem you had with this was the 10ms requirement from removal 
notification to removal completion.  Several people have already suggested 
that if that really is a hard and fast requirement, then you could simply 
treat the removal as a surprise removal rather than a planned one and work on 
fixing our surprise removal problems instead.

The bottom line is that I'm not convinced this can't be done using the 
existing infrastructure or a generic enhancement to it.

James




