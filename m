Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRH3JUB>; Thu, 30 Aug 2001 05:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271819AbRH3JTw>; Thu, 30 Aug 2001 05:19:52 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:25860 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271741AbRH3JTp>;
	Thu, 30 Aug 2001 05:19:45 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: ioctl conflicts
Date: 30 Aug 2001 08:16:22 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9ortim.352.kraxel@bytesex.org>
In-Reply-To: <20010828145304Z.haba@pdc.kth.se> <3B8DEF9D.26F7544D@cisco.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999159382 3235 127.0.0.1 (30 Aug 2001 08:16:22 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manik Raina wrote:
>  I was grep-ing on a 2.4 source tree when i found the
>  following :
>  
>  ./include/linux/videodev.h:#define VIDIOCGCAP          
>  _IOR('v',1,struct video_capability)
>  ./include/linux/ext2_fs.h:#define  EXT2_IOC_GETVERSION  _IOR('v',1,
>  long)   

The size of the argument has a different size, so they end up with
different magic numbers because of that.

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
