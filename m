Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292866AbSBVODx>; Fri, 22 Feb 2002 09:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292867AbSBVODo>; Fri, 22 Feb 2002 09:03:44 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:43282 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292866AbSBVODZ>; Fri, 22 Feb 2002 09:03:25 -0500
Date: Fri, 22 Feb 2002 15:03:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222150323.A5530@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C764B7C.2000609@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Feb 22, 2002 at 02:45:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 02:45:32PM +0100, Martin Dalecki wrote:

> See above that is *not* the proper interface for implementation choice,
> which is *user* policy anyway and can be handled fine by the
> existing generic module interface infrastructure.
> 
> For the sake of modularization. I have already at home a version
> of ide-pci.c, where the signatures of chipset initialization
> source code modules match the singature of a normal pci device
> initialization hook. This should enable it to make them true modules
> RSN.

If you can, please send this to me - I'd like to take a look.

> The chipset drivers will register lists of PCI-id's they can handle
> instead of the single only global list found in ide-pci.c.

I think it'd be even better if the chipset drivers did the probing
themselves, and once they find the IDE device, they can register it with
the IDE core. Same as all the other subsystem do this.

-- 
Vojtech Pavlik
SuSE Labs
