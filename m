Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135679AbRDXPip>; Tue, 24 Apr 2001 11:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135680AbRDXPie>; Tue, 24 Apr 2001 11:38:34 -0400
Received: from [209.10.149.20] ([209.10.149.20]:3078 "EHLO mail.real.net")
	by vger.kernel.org with ESMTP id <S135679AbRDXPi1>;
	Tue, 24 Apr 2001 11:38:27 -0400
Message-ID: <3AE59DCD.2090608@nyc.rr.com>
Date: Tue, 24 Apr 2001 11:37:49 -0400
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-pre6 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To: thomas.ford@balliol.ox.ac.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: PIO disk writes using 100% system time and performing poorly with VIA vt82c686b on kernels 2.2 & 2.4
In-Reply-To: <fa.hn82icv.1i1uioa@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Ford wrote:

> Heavy disc writes (eg. unzipping linux kernel source) cause the system
> processor usage (as reported by top/xosview) to jump to 100%, making
> the X mouse/audio freeze etc.
> 
> Such problems occur with the drives connected to VIA vt82c686b south
> bridge: the same drives on a mvp3 show no such problems.
> 
> The behaviour is the same on kernels 2.2.17 & 2.4.3 (both hand
> compiled & RedHat's 2.4.2-2 & 2.2.17-14 in case I was doing something
> wrong).
> 
> The problem is easily demonstrated by hdparm -t. The CPU use jumps to
> system 100% as above and all my drives report ~1.9 MB/sec in PIO mode
> which is far lower than PIO on the mvp3 (~10MB/s).
> 
> DMA mode appears to work fine but I am not using it due to publicised
> potential problems.
> 
> Regards,
> 
> Tom Ford
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Can you share a link to the "publicised potential problems" for DMA mode?

I'm running VIA686A using DMA mode and haven't had any problems.
However, the disk isn't operating as efficiently as I thought it would
(hdparm -t reports 16.3 MB/sec even though I'm using an 80w cable
with an ATA100 drive).  I believe that this is due in part to
corrective measures taken by RedHat to fix potential problems with
the VIA chipset; I saw it reported somewhere that the same configuration
will work 20+ MB/sec on distros like Debian).

-- 
  -o) j o h n  e   w e b e r
  / \ aspiring computer scientist & lover of pengiuns
_\_v

