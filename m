Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262972AbTCLB0N>; Tue, 11 Mar 2003 20:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262998AbTCLB0N>; Tue, 11 Mar 2003 20:26:13 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:33040 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262972AbTCLB0L>; Tue, 11 Mar 2003 20:26:11 -0500
Date: Wed, 12 Mar 2003 02:36:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, <shemminger@osdl.org>, <rml@tech9.net>,
       <zwane@linuxpower.ca>, <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>
Subject: Re: [PATCH] (0/8) replace brlock with RCU
In-Reply-To: <20030311.162831.42576307.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0303120232100.32518-100000@serv>
References: <1047428032.15874.87.camel@dell_ss3.pdx.osdl.net>
 <Pine.LNX.4.44.0303111622260.2709-100000@home.transmeta.com>
 <20030311.162831.42576307.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Mar 2003, David S. Miller wrote:

> I'm fine with it, as long as I get shown how to get the equivalent
> atomic sequence using the new primitives.  Ie. is there still a way
> to go:
> 
> 	stop_all_incoming_packets();
> 	do_something();
> 	resume_all_incoming_packets();
> 
> with the new stuff?

BTW if anyone is interested in a brlock implementation, which can offer 
this property, but can also beat rcu, you might want to look at this 
patch http://marc.theaimsgroup.com/?l=linux-kernel&m=104733360501112&w=2

bye, Roman

