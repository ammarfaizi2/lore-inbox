Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRBZWhA>; Mon, 26 Feb 2001 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBZWgu>; Mon, 26 Feb 2001 17:36:50 -0500
Received: from [204.244.205.25] ([204.244.205.25]:10820 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S129185AbRBZWgh>;
	Mon, 26 Feb 2001 17:36:37 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Reply-To: michael@linuxmagic.com
Organization: LinuxMagic Inc.
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>, Chris Wedgwood <cw@f00f.org>
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
Date: Mon, 26 Feb 2001 15:46:56 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, waltje@uWalt.NL.Mugnet.ORG
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net> <20010225163836.A12173@metastasis.f00f.org> <20010225045420.B10281@sith.mimuw.edu.pl>
In-Reply-To: <20010225045420.B10281@sith.mimuw.edu.pl>
MIME-Version: 1.0
Message-Id: <0102261546570H.02007@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing some work on some ip options stuff, I have noticed a bunchof 
unused entries in linux/include/linux/ip.h

A few things.. why is ip.h not part of the linux/include/net rather than 
linux/include/linux hierachy?

Defined items that are not used anywhere in the source..
Can any of them be deleted now?
<see below>

Also, I was looking into some RFC 1812 stuff. (Thanks for nothing Dave :) and 
was looking at 4.2.2.6 where it mentions that a router MUST implement the End 
of Option List option..  Havent' figured out where that is implememented yet..

Also was trying to figure out some things. 
I want to create a new ip_option for use in some DOS protection experiments.
I have a whole 40 bytes (+/-) to share...  Now although I don't see anything 
explicitly prohibiting the use of unused IP Header option space, I know that 
it really was designed for use by the sending parties, and not routers in 
between.. Has anyone seen any RFC that explicitly says I MUST NOT?


IPTOS_PREC_NETCONTROL
IPTOS_PREC_FLASHOVERRIDE
IPTOS_PREC_FLASH
IPTOS_PREC_IMMEDIATE
IPTOS_PREC_PRIORITY
IPTOS_PREC_ROUTINE
IPOPT_RESERVED1
IPOPT_RESERVED2
IPOPT_OPTVAL
IPOPT_OLEN
IPOPT_MINOFF
MAX_IPOPTLEN
IPOPT_EOL



> diff -urN linux/include/net/ip.h linux.fixed/include/net/ip.h
--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
