Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290259AbSBORtQ>; Fri, 15 Feb 2002 12:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290344AbSBORtH>; Fri, 15 Feb 2002 12:49:07 -0500
Received: from host194.steeleye.com ([216.33.1.194]:24074 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S290259AbSBORsw>; Fri, 15 Feb 2002 12:48:52 -0500
Message-Id: <200202151748.g1FHmic02300@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Fri, 15 Feb 2002 12:17:49 EST." <4044420000.1013793468@tiny> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 12:48:44 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mason@suse.com said:
> I'm thinking about dropping the scsi parts of the 2.4 barrier patch,
> and just worrying about making ide  drives flush things correctly.
> The hard stuff on error recovery can be tackled in 2.5 and (maybe)
> ported back later.

That's probably best.  I do agree that 2.5 is the place to play around with 
SCSI error handling first.

I'm willing to help re-do the error handler, since I've always thought that 
abort isn't a good first line of defence because it actually adds to the 
command burden of a failing drive.

Jens, if you want to share the code you already have (or point me to the 
bitkeeper repository where you keep it) I'll look it over.

As far as the back-port to 2.4, as long as you only support SCSI drivers that 
use the new error handler (so we don't have to worry about the obsolete one) 
that should be reasonably easy.

James


