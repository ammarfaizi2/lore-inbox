Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUHGPLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUHGPLY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 11:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUHGPLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 11:11:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14786 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263024AbUHGPLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 11:11:06 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040806143258.GB23263@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
	 <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de>
	 <20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de>
	 <1091739966.8418.38.camel@localhost.localdomain>
	 <20040806054424.GB10274@suse.de> <20040806062331.GE10274@suse.de>
	 <1091794470.16306.11.camel@localhost.localdomain>
	 <20040806143258.GB23263@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091887718.18407.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 15:08:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 15:32, Jens Axboe wrote:
> That's the case I don't agree with, and why I didn't like the idea
> originally. That suddenly requires a patching of the kernel because of
> new commands in new devices. Like when dvd readers became common, you
> can't just require people to update their kernel because a few new
> commands are needed to drive them from user space.

I'm stunning we are even having this argument. You are talking about
what appes to be a hardware destruction enabling security level bug in
the 2.6 kernel and arguing about whether it is a feature or not.

In essence you are saying read access to any raw device node entitles
the opener of the file to destroy the attached device (device even not
just media). You are arguing that its ok that I can use raw scsi I/O to
subvert the read/write permissions too.

In the example code I gave

>               default:
>                       if(capable(CAP_SYS_RAWIO))
>                       /* Only administrators get to do arbitary things
*/
> 

means there is no need to recompile anything, you just need priviledges
to do stuff the kernel doesn't *know* is safe. This is the correct
behaviour for people who don't live in cloud cuckoo land.

Alan

