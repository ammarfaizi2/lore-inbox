Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276608AbRI2Udk>; Sat, 29 Sep 2001 16:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276609AbRI2Uda>; Sat, 29 Sep 2001 16:33:30 -0400
Received: from ns.suse.de ([213.95.15.193]:22291 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S276608AbRI2UdX>;
	Sat, 29 Sep 2001 16:33:23 -0400
Date: Sat, 29 Sep 2001 22:33:47 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Andre Hedrick <andre@aslab.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC (patch below) Re: ide drive problem?
In-Reply-To: <Pine.LNX.4.10.10109291309050.28810-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0109292229380.21394-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Andre Hedrick wrote:

> This is an error that I am considering removing form the user's view.
> For the very fact/reason you are pointing out; however, it becomse
> more painful when performing error sorting.

Another 'error' you may want to silence some time is the one
that appears when you query SMART status of a recent IBM drive.

hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hde: drive_cmd: error=0x04 { DriveStatusError }

This happens if the drive is SMART capable, but not SMART enabled,
and you ask it if it can do SMART.  Once you enable it, subsequent
queries work without spitting out the error.
(Unless you turn it off again)

I'm not sure if this a quirk of these drives (I've not seen it happen
on any other vendor), or the code.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

