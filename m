Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRDPSAg>; Mon, 16 Apr 2001 14:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbRDPSA1>; Mon, 16 Apr 2001 14:00:27 -0400
Received: from thorin.y.ics.muni.cz ([147.251.61.126]:4615 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S131809AbRDPSAP>; Mon, 16 Apr 2001 14:00:15 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Mon, 16 Apr 2001 20:00:12 +0200
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/block/loop.c:max_loop
Message-ID: <20010416200012.H6934@informatics.muni.cz>
In-Reply-To: <20010416173942.G6934@informatics.muni.cz> <20010416183637.G9539@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010416183637.G9539@suse.de>; from axboe@suse.de on Mon, Apr 16, 2001 at 06:36:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
: On Mon, Apr 16 2001, Jan Kasprzak wrote:
: > 	Hello,
: > 
: > 	I run a relatively large FTP server, and I've just reached
: > the max_loop limit of loop devices here (I use loopback mount of ISO 9660
: > images of Linux distros here). Is there any reason for keeping
: > the max_loop variable in loop.c set to 8?
: 
: Memory requirements -- nothing prevents you from loading it with a
: bigger max count though...
: 
	I would suggest to make the limit configurable by /proc or
ioctl() in run-time. Or even better, to make all allocations on
first /dev/loopN open. Should I try to implement something like that?

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
Mantra: "everything is a stream of bytes". Repeat until enlightened. --Linus
