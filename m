Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316506AbSEOW1B>; Wed, 15 May 2002 18:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316510AbSEOW1A>; Wed, 15 May 2002 18:27:00 -0400
Received: from smtp.comcast.net ([24.153.64.2]:18161 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S316506AbSEOW06>;
	Wed, 15 May 2002 18:26:58 -0400
Date: Wed, 15 May 2002 17:36:27 -0400
From: Russell Leighton <russ@elegant-software.com>
Subject: Re: InfiniBand BOF @ LSM - topics of interest
To: Tony.P.Lee@nokia.com
Cc: wookie@osdl.org, alan@lxorguk.ukuu.org.uk, lmb@suse.de, woody@co.intel.com,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
Message-id: <3CE2D4DB.3020702@elegant-software.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9)
 Gecko/20020311
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2071@mvebe001.NOE.Nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lot's of very cool ideas for IB ...not knowing much about IB, but
being curious and interested, I have a question which may be stupid
so I apoligize in advance if it is...

Can we really have these sort of low level IB interactions and have :
    - security issues addressed, mostly an issue if the devices are over 
a network w/other devices
       doing other things for other processes/people...
       (I get the a bit scared when someone suggests that a remote 
device can write directly to my frame
         buffer or disk, I hope there are security controls in place!)
    - congestion control (already mentioned)
    - qos control

OR is it saner to layer TCP/IP etc. over IB... it seems to me the point
others were making was that  there is more to "network"  style services
than just passing bits from here to there...will IB have low level
support many of the features people have come to expect?

Thanks!

Russ


Tony.P.Lee@nokia.com wrote:

>
>For VNC type application, instead server translates
>every X Windows, Mac, Windows GUI calls/Bitmap update
>to TCP stream, you convert the GUI API calls to 
>IB RC messages and bitmap updates to RDMA write directly 
>to client app's frame buffer.  
>
>For SAMBA like fs, the file read api can be translated to 
>IB RC messages on client + RDMA write to remote 
>client app's buffer directly from server.
>
>They won't be "standard" VNC/SAMBA any more. 
>
>On the other hand, we can put VNC over TCP over IP over IB,
>- "for people with hammer, every problem looks like a nail." :-)
>
>In theory, we can have IB DVD drive RDMA video directly 
>over IB switch to IB enable VGA frame buffer and completely
>by pass the system.  CPU only needed setup the proper 
>connections.   The idea is to truely virtualized the system
>resources and "resource server" RDMA the data to anyone on IB
>switch with minimal CPU interaction in the process.
>
>You can also config a normal SCSI card DMA data to virtualized 
>IB address on PCI address space and have the data shows up 15 meters
>or 2 km away on server's "virtual scsi driver" destination DMA address.
>It made iSCSI looked like dial up modem in term of performance
>and latency. 
>
>
>----------------------------------------------------------------
>Tony 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


