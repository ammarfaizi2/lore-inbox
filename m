Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290389AbSBKUnB>; Mon, 11 Feb 2002 15:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290377AbSBKUmp>; Mon, 11 Feb 2002 15:42:45 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:31454 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S290361AbSBKUmU>; Mon, 11 Feb 2002 15:42:20 -0500
Message-ID: <3C682CA2.5060407@nyc.rr.com>
Date: Mon, 11 Feb 2002 15:42:10 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Weber <weber@nyc.rr.com>
CC: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.5.4 Sound Driver Problem
In-Reply-To: <fa.c0t1afv.1f02hrj@ifi.uio.no> <fa.jvah72v.1h34cqd@ifi.uio.no> <3C682264.7060707@nyc.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:
>> Try to do this. Open drivers/sound/Config.in, and find YMFPCI
>> tristate, then delete $CONFIG_SOUND_OSS from that line.
>> Edit .config, and remove CONFIG_SOUND_OSS. Rerun make oldconfig,
>> when prompted for CONFIG_SOUND_OSS, say N. This should work.
> 
> 
> if [ "$CONFIG_SOUND_OSS" = "y" -o "$CONFIG_SOUND_OSS" = "m" ]; then
>    bool '      Verbose initialisation' CONFIG_SOUND_TRACEINIT
>    bool '      Persistent DMA buffers' CONFIG_SOUND_DMAP
> 
> The YMFPCI option was in the body of the above if statement, so I had
> to move it out of there to be able to enable it without enabling 
> CONFIG_SOUND_OSS.  I hope this is what you meant.
> 

This works, by the way.

