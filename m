Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270643AbRHNSbd>; Tue, 14 Aug 2001 14:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270652AbRHNSb1>; Tue, 14 Aug 2001 14:31:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24593 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270656AbRHNSbG>; Tue, 14 Aug 2001 14:31:06 -0400
Message-ID: <3B79550F.4030800@zytor.com>
Date: Tue, 14 Aug 2001 09:42:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>	<9kuid8$q57$1@cesium.transmeta.com>	<m1n157rrpk.fsf@frodo.biederman.org>	<9l2p9e$89h$1@cesium.transmeta.com> <m166brqeyc.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
>>From your reaction I'm not explaining myself well.  And since I'm
> working with a work in progress that isn't too much of a suprise.
> 
> The basic rule is that nothing that can be queried from the hardware
> directly should be passed to the kernel.  However we do need to have
> an interface to describe the hardware that we can't do a
> PCI/ISAPNP/USB/etc bus scan to get.  To a certain extent the
> information is optional because sometimes we cannot get it.  But if we
> can it is good to have.  
> 
> That is all I intend to pass to the linux kernel besides a command
> line the unprobeable hardware details.  If something becomes probeable
> in the future that wasn't in the past, I'd spec it as optional to pass
> that information.  
> 
> For the kernel loaders I'd definentily have a standard probe routine
> that would query the traditional BIOS, and then package the results in
> the format I'm suggesting.  Because of working around BUGS sometimes
> you need extra information that gets lost in translation, so I'm not
> 100% certain that is the best way to go.  However it is possible to
> turn things on their heads and share the same code between multiple
> operating systems at which point it makes real sense to move that code
> into a bootloader.  This is one of those questions worth looking very
> closely at.
> 

The point is that this belongs in the kernel image, so that it can be 
evolved, not in the boot loaders, where it becomes static.  These kinds 
of things will in practice change too quickly to be frozen into boot 
loaders.

It's still a bad idea.

	-hpa

