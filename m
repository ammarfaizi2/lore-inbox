Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSGLSaq>; Fri, 12 Jul 2002 14:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSGLSap>; Fri, 12 Jul 2002 14:30:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64013 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316753AbSGLSak>; Fri, 12 Jul 2002 14:30:40 -0400
Message-ID: <3D2F20DD.1030704@zytor.com>
Date: Fri, 12 Jul 2002 11:33:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.LNX.4.44.0207121050230.14359-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 12 Jul 2002, Martin Dalecki wrote:
> 
>>So Linus what's your opinnion please?
> 
> 
> I will violently oppose anything that implies that the IDE layer uses the
> SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
> that should be scrapped is ide-scsi.
> 
> The higher layers already have much of what the SCSI layer does, and the
> SCSI layer itself is slowly moving in that direction.
> 

Then *please* make a *compatible* interface available to user space. 
This certainly can be done; the parallel port IDE interface stuff had 
exactly such an interface (/dev/pg*) -- we could have a /dev/hg* 
interface presumably.  That is an acceptable solution.

Note again that this discussion (and it's a discussion, not a voting 
session -- technical pros and cons is what applies) apply to ATAPI (SCSI 
over IDE) only.  Alan has already brought up the fact of non-hard disk 
non-ATAPI devices, and IMO those devices are explicitly out of scope. 
Maturity of drivers is another, but right now we're suffering through 
having to deal with multiple drivers for the same hardware, or with user 
space having to choose different interfaces depending on connection 
interface, and either which way that's pretty pathetic.

	-hpa


