Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRD3Jbx>; Mon, 30 Apr 2001 05:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRD3Jbo>; Mon, 30 Apr 2001 05:31:44 -0400
Received: from tilde.ookhoi.dds.nl ([194.109.10.165]:24705 "HELO
	humilis.ookhoi.dds.nl") by vger.kernel.org with SMTP
	id <S131626AbRD3Jbd>; Mon, 30 Apr 2001 05:31:33 -0400
Date: Mon, 30 Apr 2001 11:31:18 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Francois Gouget <fgouget@free.fr>
Cc: linux-kernel@vger.kernel.org, elmer@ylenurme.ee
Subject: Re: Aironet doesn't work
Message-ID: <20010430113117.F324@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <Pine.LNX.4.21.0104300011070.10183-100000@amboise.dolphin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0104300011070.10183-100000@amboise.dolphin>; from fgouget@free.fr on Mon, Apr 30, 2001 at 12:25:18AM -0700
X-Uptime: 13:06:18 up 4 min,  4 users,  load average: 0.07, 0.13, 0.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois,

>    I'm having trouble getting a Cisco 340 wireless card to work with the
> aironet driver from 2.4.3-ac6. The driver loads fine but then cardmgr
> says:
> 
> Apr 29 22:37:35 oleron cardmgr[613]: initializing socket 0
> Apr 29 22:37:35 oleron cardmgr[613]: socket 0: Aironet PC4800
> Apr 29 22:37:35 oleron cardmgr[613]: executing: 'modprobe aironet4500_core'
> Apr 29 22:37:35 oleron cardmgr[613]: executing: 'modprobe aironet4500_cs'
> Apr 29 22:37:36 oleron cardmgr[613]: get dev info on socket 0 failed: Resource temporarily unavailable
> 
>    I'm using the debian pcmcia-cs package version 3.1.22-0.2potato. I
> would be happy to help debug this but I won't have the card for long.
> Where should I go from there?
>    My laptop is a Sony Vaio F560. I also have a 3com pcmcia network card
> which works just fine so I know that pcmcia is working. I tried the
> cisco card in each socket, with and without the 3com card at the same
> time. My /etc/pcmcia/config file says:
> 
> --- cut here ---
> device "airo_cs"
>   class "network" module "aironet4500_core", "aironet4500_cs"
> #  class "network" module "airo", "airo_cs"
> 
> card "Aironet PC4500"
>   manfid 0x015f, 0x0005
>   bind "airo_cs"
> 
> card "Aironet PC4800"
>   manfid 0x015f, 0x0007
>   bind "airo_cs"
> --- cut here ---

The aironet drivers included in the kernel never worked for me (early
2.4.x-ac), so I use the airo and airo_cs modules which are disabled in
your pcmcia config.

You find the sources at www.cse.ucsc.edu/~breed (airo.c and airo_cs.c).
Copy them over the airo.c and airo_cs.c in pcmcia-cs-3.1.xx/wireless,
build the modules and there you are. :-)

	Ookhoi
