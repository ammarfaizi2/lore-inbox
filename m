Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSFQO32>; Mon, 17 Jun 2002 10:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSFQO32>; Mon, 17 Jun 2002 10:29:28 -0400
Received: from host194.steeleye.com ([216.33.1.194]:31249 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314078AbSFQO31>; Mon, 17 Jun 2002 10:29:27 -0400
Message-Id: <200206171429.g5HETBV02481@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Kurt Garloff <kurt@garloff.de>, Oliver Neukum <oliver@neukum.name>,
       dougg@torque.net, Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Brownell <david-b@pacbell.net>, Andries.Brouwer@cwi.nl,
       sancho@dauskardt.de, linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [garloff@suse.de: Re: [linux-usb-devel] Re: /proc/scsi/map] 
In-Reply-To: Message from Kurt Garloff <kurt@garloff.de> 
   of "Mon, 17 Jun 2002 03:24:00 +0200." <20020617012400.GH21461@gum01m.etpnet.phys.tue.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jun 2002 09:29:11 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kurt@garloff.de said:
> This may work for your disks. You just can't open the device node for
> a tape, if there is no medium inserted. If you know the mapping
> between to a sg device you can use it.

Actually, you have to use sg for a disc as well since you send a scsi CDB 
directly to the device for inquiry page 0x83.

> That's the second piece of information that /proc/scsi/map provides. 

Oh no question.  The way the current code doing this works is that it opens 
all scsi devices and issues a GET_IDLUN to compile a database of the nodes and 
then matches them up to sg nodes.

James


