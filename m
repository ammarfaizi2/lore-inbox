Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278528AbRJSP6p>; Fri, 19 Oct 2001 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278527AbRJSP6g>; Fri, 19 Oct 2001 11:58:36 -0400
Received: from www.stolica.ru ([62.118.250.25]:28376 "HELO stolica.ru")
	by vger.kernel.org with SMTP id <S278526AbRJSP6W>;
	Fri, 19 Oct 2001 11:58:22 -0400
Date: Fri, 19 Oct 2001 19:53:28 +0400
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: problems with I/O performance with 2.4.12-ac3
Message-ID: <20011019195328.A30781@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On my machine HDD is slow with all ac-kernels I've tried so far.
There is even more simple test -- hdparm.

2.4.12-ac3:
# hdparm -tT /dev/hda
/dev/hda:
Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
Timing buffered disk reads:  64 MB in  2.88 seconds = 22.22 MB/sec

2.4.13-pre3:
# hdparm -tT /dev/hda
/dev/hda
Timing buffer-cache reads:   128 MB in  0.63 seconds =203.00 MB/sec
Timing buffered disk reads:  64 MB in  1.57 seconds = 40.76 MB/sec

Same config options in both kernels. Same hardware.

# hdparm /dev/hda
/dev/hda:
multcount    = 16 (on)
I/O support  =  1 (32-bit)
unmaskirq    =  1 (on)
using_dma    =  1 (on)
keepsettings =  1 (on)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 4865/255/63, sectors = 78165360, start = 0
	 
This is on Athlon-1.4Ghz, chipset amd761/via8231, 
IDE Seagate Barracuda ATA-IV ST340016A 40G.
Can somebody explain such results?

-- 

    DV
