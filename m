Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTFKQqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTFKQqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:46:25 -0400
Received: from dsl-212-23-25-139.zen.co.uk ([212.23.25.139]:39075 "EHLO
	butternut.transitive.com") by vger.kernel.org with ESMTP
	id S262955AbTFKQqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:46:24 -0400
Message-ID: <3EE75FF0.3080702@treblig.org>
Date: Wed, 11 Jun 2003 17:59:28 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: war <war@lucidpixels.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apiszcz@solarrain.com
Subject: Re: WESTERN DIGITAL 200GB IDE DRIVES GO OFFLINE - HOW TO FIX
References: <Pine.LNX.4.53.0306111115530.14178@p500> <1055346538.2420.3.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-06-11 at 16:36, war wrote:
> 
>>I've searched the archives, google and so on, many questions relating to
>>why the Western Digital drives go offline exist but with no answers.
>>
>>PROBLEM: After extended periods of time, the HDD will simply go offline.
>>
>>EXAMPLE LOG ENTRY:
>>
>>Jun  2 02:07:26 l2 kernel: hdg: dma_intr: status=0x61 { DriveReady
>>DeviceFault Error }
>>Jun  2 02:07:26 l2 kernel: hdg: dma_intr: error=0x04 { DriveStatusError }
>>Jun  2 02:07:26 l2 kernel: hdg: DMA disabled
> 
> 
> "DeviceFault" and "Error"
> 
> Those are return values I associate with device (ie hardware) faults
> oddly enough 8)

In many cases these drives with the older firmware don't even grace you 
with the benefit of an IDE error; they just give random file system 
corruption.  I believe that this was the cause of the problems I was 
reporting here:
http://www.cs.helsinki.fi/linux/linux-kernel/2003-14/0935.html

after updating the firmware both systems seem to be OK.

So even if you aren't actually seeing these errors, even if you aren't 
using RAID I'd suggest getting this patch.

Dave

