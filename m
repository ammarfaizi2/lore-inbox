Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293223AbSCAQAo>; Fri, 1 Mar 2002 11:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293205AbSCAQA2>; Fri, 1 Mar 2002 11:00:28 -0500
Received: from host194.steeleye.com ([216.33.1.194]:40716 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S293005AbSCAQAO>; Fri, 1 Mar 2002 11:00:14 -0500
Message-Id: <200203011600.g21G09V01987@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Dieter =?iso-8859-15?q?N=FCtzel?= 
 <Dieter.Nuetzel@hamburg.de>
   of "Fri, 01 Mar 2002 16:26:27 +0100." <200203011626.27719.Dieter.Nuetzel@hamburg.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Mar 2002 10:00:09 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter.Nuetzel@hamburg.de said:
> How do you checked it? 

I used sginfo from Doug Gilbert's sg utilities (http://www.torque.net/sg)

The version was sg3_utils-0.98

Dieter.Nuetzel@hamburg.de said:
> But when I use "scsi-config" I get under "Cache Control Page": Read
> cache enabled: Yes Write cache enabled: No 

I believe write cache enabled is the state of the WCE bit and read cache 
enabled is the inverse of the RCD bit, so you have a write through cache.

I think that notwithstanding the spec, most drives are write through (purely 
because of the safety aspect).  I suspect certain manufacturers use write back 
caching to try to improve performance figures (at the expense of safety).

James


