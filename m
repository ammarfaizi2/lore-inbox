Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285745AbRLHBxb>; Fri, 7 Dec 2001 20:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbRLHBxQ>; Fri, 7 Dec 2001 20:53:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6406 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285745AbRLHBw7>; Fri, 7 Dec 2001 20:52:59 -0500
Message-ID: <3C117270.6070006@zytor.com>
Date: Fri, 07 Dec 2001 17:52:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: mjustice@austin.rr.com
CC: linux-kernel@vger.kernel.org
Subject: Re: highmem question
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719300102.00764@bozo> <3C116CC6.2030808@zytor.com> <01120719534703.00764@bozo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marvin Justice wrote:

>>The problem is that in the x86 architecture you don't have any reasonable
>>way of addressing the physical address space, so you need to map it into
>>the virtual address space.  You end up with a shortage of virtual address
>>space.
>>
> 
> Isn't this still just an artifact of the default 1:3 kernel/user virtual 
> address space split? I've never tried it myself but isn't there a 2:2 patch 
> available that has the effect of moving the highmem boundary up?
> 


You can tweak the split... both 2:2 and 0.5:3.5 splits have been used...
but it's not without side effects.  Cutting your user space breaks
applications which want large mmap() areas, for example.


> 
>>There is no way of fixing it.
>>
> 
> All I know is that a streaming io app I was playing with showed a drastic 
> performance hit when the kernel was compiled with CONFIG_HIGHMEM. On W2K we 
> saw no slowdown with 2 or even 4GB of RAM so I think solutions must exist.
> 


Of course you didn't.  Win2K runs with the equivalent of HIGHMEM all the
time.

	-hpa


