Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbTCICiQ>; Sat, 8 Mar 2003 21:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbTCICiQ>; Sat, 8 Mar 2003 21:38:16 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:45844 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262411AbTCICiP>; Sat, 8 Mar 2003 21:38:15 -0500
Message-ID: <3E6A3BAF.7020708@myrealbox.com>
Date: Sat, 08 Mar 2003 18:51:27 +0000
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre5-ac2:  kernel oops with "swapoff -a"
References: <fa.hhhab3c.11n83hg@ifi.uio.no> <fa.fk1qpc0.s4022c@ifi.uio.no>
In-Reply-To: <fa.fk1qpc0.s4022c@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Alan Cox wrote:
> 
>> On Sat, 2003-03-08 at 11:07, walt wrote:
>>
>>> When I do "swapoff -a" I still see the kernel oops that began with 
>>> -pre4-ac7
>>> and has propagated to every 'ac' kernel since then.
> 
> 
>> Can you send me an strace swapoff -a ?


> swapoff("/dev/hda10")                   = -1 EINVAL (Invalid argument)
> read(3, "", 4096)                       = 0
> _exit(0)                                = ?


On further investigation I find that "swapoff <anyPartition>" will produce
the same oops and segfault in /sbin/swapoff, whereas if I supply a totally
bogus argument like 'swapoff xyz' I get an appropriate error message
instead of the oops:

swapoff("xyz")                          = -1 ENOENT (No such file or directory)
write(2, "swapoff: xyz: No such file or di"..., 40swapoff: xyz: No such file or 
directory
) = 40
_exit(-1)                               = ?


