Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269969AbRHEQAs>; Sun, 5 Aug 2001 12:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269766AbRHEQAi>; Sun, 5 Aug 2001 12:00:38 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:9232 "HELO
	mail11.speakeasy.net") by vger.kernel.org with SMTP
	id <S269969AbRHEQA0>; Sun, 5 Aug 2001 12:00:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Nico Schottelius <nicos@pcsystems.de>
Subject: Re: 3c509: broken(verified)
Date: Sun, 5 Aug 2001 12:00:35 -0400
X-Mailer: KMail [version 1.3]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E15TNpL-0007rV-00@the-village.bc.nu> <3B6D56C5.1AA10E84@pcsystems.de>
In-Reply-To: <3B6D56C5.1AA10E84@pcsystems.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010805160035Z269969-28344+1638@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 August 2001 10:23, Nico Schottelius wrote:
> Alan Cox wrote:
> > > The driver for the 3c509 of 2.4.7 is broken:
> > > It is impossible to set the transmitter type.
> > > modprobe 3c509 xcvr=X, where X is
> > > 0,1,2,3,4 doesn't make a difference.
> >
> > Looking at the code it should set the type fine. The only bug I can see
> > is that it will report the default type set in the eeprom not the type
> > you asked.
> >
> > If thats the case (please check) then its trivial to fix
>
> While I tried to setup the driver I always let one machine
> outside ping it.
>
> It is not just the message.
>
> ozean:~ # modprobe 3c509 ; ifconfig eth1 192.168.4.17 up
>
> eth1: 3c5x9 at 0x360, BNC port, address  00 60 97 39 43 b9, IRQ 5.
> 3c509.c:1.18 12Mar2001 becker@scyld.com
> http://www.scyld.com/network/3c509.html
>
> - the light on the hub keeps off, no ping answer
>
> ozean:~ # ifconfig eth1 down ; rmmod 3c509;
>
> ozean:~ # modprobe 3c509 xcvr=4 debug=4
>
> ## xcvr=4 is TP (found on scyld.com/network/3c509.html)
>
>
> 3c509.c:1.18 12Mar2001 becker@scyld.com
> http://www.scyld.com/network/3c509.html
> eth1: Setting Rx mode to 1 addresses.
>   3c509 EEPROM word 7 0x6d50.
>   3c509 EEPROM word 0 0x0060.
>   3c509 EEPROM word 1 0x9739.
>   3c509 EEPROM word 2 0x43b9.
>   3c509 EEPROM word 8 0xc096.
>   3c509 EEPROM word 9 0x5000.
>
> eth1: 3c5x9 at 0x360, BNC port, address  00 60 97 39 43 b9, IRQ 5.
> 3c509.c:1.18 12Mar2001 becker@scyld.com
> http://www.scyld.com/network/3c509.html
>   3c509 EEPROM word 7 0xffff.
> eth1: Opening, IRQ 5     status@36e 0000.
> eth1: Opened 3c509  IRQ 5  status 2000.
> eth1: Setting Rx mode to 1 addresses.
>
> ozean:~ # ifconfig eth1 192.168.4.17 up
>
> - ping does not work, no light is seen
>
>
> That's it! The cable & the hub are okay.
>
>
> Nico
>

i was just using a 3c509 in my friend's old 486 and it was working fine with 
2.4.7.   Just modprobed it and set up the ips and it was able to ping and be 
pinged.   
