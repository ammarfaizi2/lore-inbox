Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293472AbSBYTnk>; Mon, 25 Feb 2002 14:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293474AbSBYTnb>; Mon, 25 Feb 2002 14:43:31 -0500
Received: from 25-VALL-X12.libre.retevision.es ([62.83.208.153]:30480 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S293472AbSBYTnY>; Mon, 25 Feb 2002 14:43:24 -0500
Date: Mon, 25 Feb 2002 20:42:38 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: linux-kernel@vger.kernel.org
Cc: Vincent Bernat <bernat@free.fr>
Subject: Re: static arp table doesn't size up ?
Message-ID: <20020225204238.A10218@ragnar-hojland.com>
In-Reply-To: <m34rk5suyk.fsf@neo.loria>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <m34rk5suyk.fsf@neo.loria>; from bernat@free.fr on Mon, Feb 25, 2002 at 11:43:15AM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 11:43:15AM +0100, Vincent Bernat wrote:
> Hi !
> 
> We have a 2.4.16 generic kernel and we run into troubles with arp. We
> have an ethernet segment of 600+ machines. On one of these machines, I
> have set up a static arp table by entering every mac-ip couple.
> 
> For several days, I have left the ARP learning (ifconfig eth0 arp) and
> there was no problem. Every 5 minutes, I have checked if there was
> learned address in the arp cache : there was none, so it didn't learn
> any new address.
> 
> Today, I have switch to a real static arp table (with ifconfig eth0
> -arp). Randomly, some machines were then unable to ping the
> host.
> 
> After a "ifconfig eth0 arp ; ifconfig eth0 -arp", this some other
> machine which were unable to ping the host where the first machines
> are able to do it again. arp table is correct but randomly, some
> machines are unable to get their echo reply, even if its entry is in
> the arp table.
> 
> Are there known issues about large arp tables ?

You may want to try to increment the thresholds for garbage collection in
net/ipv4/arp.c or play with the userland arpd in case the kernel is having
problem allocating as many ARP entries as you are using.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [20 pend. Mar 10]
