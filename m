Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273254AbRI0PSQ>; Thu, 27 Sep 2001 11:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273256AbRI0PR4>; Thu, 27 Sep 2001 11:17:56 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:21888 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S273254AbRI0PRx>;
	Thu, 27 Sep 2001 11:17:53 -0400
Date: Thu, 27 Sep 2001 17:18:18 +0200
From: Ookhoi <ookhoi@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] netconsole - log kernel messages over the network. 2.4.10.
Message-ID: <20010927171818.H774@humilis>
Reply-To: ookhoi@dds.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Uptime: 20:46:40 up 5 min,  5 users,  load average: 1.80, 0.73, 0.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Ingo was not aware of the sourceforge project, and suggested me to
resend my reply to lkml. Does the patch work for you guys? Do I do
something wrong? That would be more than possible. :-)


----- Forwarded message from Ookhoi <ookhoi@dds.nl> -----

To: Ingo Molnar <mingo@elte.hu>
Cc: netconsole-devel@lists.sourceforge.net

Hi Ingo,

> this is the first public release of the 'netconsole patch', a debugging
> patch that implements kernel-level network logging via UDP packets.

Is this different from the netconsole project on sourceforge? The last
message on that lists seemes to be from july, and you didn't cc it. 

> the kernel patch (against 2.4.10 or 2.4.9-ac), and a simple user-space
> tool to display netconsole messages can be found at:
>
> 	http://redhat.com/~mingo/netconsole-patches/

Can you also make older patches available for testing? The current
netconsole-2.4.10-B1 doesn't seem to work for me on plain 2.4.10 or
2.4.9-ac15 patched with Rik his latest vm patch. The patch applies fine,
but I can't load the module:

cuddle:~# uname -a
Linux cuddle 2.4.9-ac15 #1 Thu Sep 27 13:54:51 CEST 2001 i686 unknown
cuddle:~# insmod netconsole dev=eth0 target_ip=0x0a604875 source_port=6666 target_port=5555
Using /lib/modules/2.4.9-ac15/kernel/drivers/net/netconsole.o
/lib/modules/2.4.9-ac15/kernel/drivers/net/netconsole.o: init_module: Operation not permitted
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

The same message for plain 2.4.10, and the same when I use the script
netconsole-server included in netconsole-client-20010927. I also tried
it with the target_eth_byte0 thingies, with the mac address from the
local nic.

Target ip address is 10.96.72.117 (I hope 0x0a604875 is oke)

> sample startup of the netconsole on the server:
> 
>      insmod netconsole dev=eth1 target_ip=0x0a000701 \
>                   source_port=6666 \
>                   target_port=6666 \
>                   target_eth_byte0=0x00 \
>                   target_eth_byte1=0x90\
>                   target_eth_byte2=0x27 \
>                   target_eth_byte3=0x8C \
>                   target_eth_byte4=0xA0 \
>                   target_eth_byte5=0xA8
> 
> and on the client:
> 
> 	# ./netconsole-client -server 10.0.7.5 -client 10.0.7.1 -port 6666
>         [...network console startup...]
>         netconsole: network logging started up successfully!
>         SysRq : Loglevel set to 9
> 
> more about features and limitations can be found under:
> 
> 	Documentation/networking/netlogging.txt
> 
> reports, comments, suggestions welcome.

Somebody more or less asked this already, but, will things like SysRq
work in the future? That would be great. :-)  Thnx!

	Ookhoi

----- End forwarded message -----
