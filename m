Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbTFASIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTFASIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:08:55 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:33987 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264694AbTFASIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:08:36 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Subject: Re: USB 2.0 with 250Gb disk and insane loads
Date: Sun, 1 Jun 2003 20:21:40 +0200
User-Agent: KMail/1.5.1
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
References: <3EDA0E5D.8080404@pacbell.net> <200306011653.47958.oliver@neukum.org> <87k7c5g738.fsf@lapper.ihatent.com>
In-Reply-To: <87k7c5g738.fsf@lapper.ihatent.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306012021.41147.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Probably the block layer as it waits for free io slots.
> > But that doesn't tell us why the requests are not executed.
> > Where is SCSI timeout kicking in?
>
> I'm not seeing any scsi timeouts in the logs.

So it seems that the driver doesn't fail utterly, but crawls along.
Storage's debugging output should clarify the situation.

[..]
> > Could you try on USB1.1 only?
>
> Stuck it in an older machine on USB 1.1 and it foudn the disk fine
> (redhat 9, 2.4.20-13.9 kernel on that machine), and ditto result:
>
> 19:15:16  up 2 days, 20:23,  4 users,  load average: 6.02, 2.41, 0.89
> 58 processes: 55 sleeping, 3 running, 0 zombie, 0 stopped
> CPU states:   0.2% user   4.0% system   0.0% nice   0.0% iowait  95.8% idle
> Mem:   385040k av,  380820k used,    4220k free,       0k shrd,   67368k
> buff 224720k active,              69412k inactive
> Swap:  521632k av,      80k used,  521552k free                  237452k
> cached
>
> and generating about 2500 interrupts for the usb controller per 10
> seconds and when i finally break it off and give it "sync" it uses
> about two minutes with about 4500 per 10 seconds to get it all on
> disk. On 2.4 the machine becomes more and more sluggish if I let it go
> more than a short minute.

Which 2.4 ?

	Regards
		Oliver

