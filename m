Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWAYPOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWAYPOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWAYPOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:14:03 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:30683 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751225AbWAYPOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:14:01 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 16:13:00 +0100
To: matthias.andree@gmx.de, jengelh@linux01.gwdg.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D7957C.nailD7861G8B8@burner>
References: <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org>
 <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <20060124181813.GA30863@merlin.emma.line.org>
In-Reply-To: <20060124181813.GA30863@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> cdrecord simply assumes that if you don't have access to /dev/hda,
> scanning the other devices is pointless, on the assumption it were a
> security risk. How this fits into user profiles that might allow access
> to /dev/hdc, is unclear to me.

Wrong: cdrecord asumes nothing. It is the SCSI Generic transport library libscg.

Note that libscg does not offer access to a block layer device like /dev/hd* 
but rather to the transport layer _below_ /dev/hd*. If you ignore this fact you 
will have problems to understand the rules.

> > If you can access a _harddisk_ as a normal user, you _do have_ a security 
> > problem. If you can access a cdrom as normal user, well, the opinions 
> > differ here. I think you _should not either_, because it might happen that 
> > you just left your presentation cd in a cdrom device in a public box. You 
> > would certainly not want to have everyone read that out.
>
> That's less of a problem than sending vendor-specific commands - one
> might be "update firmware", which would allow the user to destroy the
> drive.

I am not sure whether you understood the problem here. Cdrtools need to deal 
with a lot of vendor specific commands. 

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
