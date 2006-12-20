Return-Path: <linux-kernel-owner+w=401wt.eu-S964960AbWLTJYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWLTJYK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWLTJYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:24:10 -0500
Received: from stinky.trash.net ([213.144.137.162]:38279 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964958AbWLTJYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:24:08 -0500
Message-ID: <45890135.9000306@trash.net>
Date: Wed, 20 Dec 2006 10:24:05 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <manty@manty.net>
CC: linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net
Subject: Re: ebtables problems on 2.6.19.1
References: <20061218082413.GA11064@clandestino.aytolacoruna.es>
In-Reply-To: <20061218082413.GA11064@clandestino.aytolacoruna.es>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Garcia Mantinan wrote:
> Hi!
> 
> When trying to upgrade a machine from 2.6.18 to 2.6.19.1 I found that it
> crashed when loading the ebtables rules on startup.
> 
> This is an example of the crash I get:
> 
> BUG: unable to handle kernel paging request at virtual address e081e004         
>  printing eip:                                                                  
> c0283da0                                                                        
> *pde = 1fbcb067                                                                 
> *pte = 00000000                                                                 
> Oops: 0000 [#1]                                                                 
> CPU:    0                                                                       
> EIP:    0060:[<c0283da0>]    Not tainted VLI                                    
> EFLAGS: 00010282   (2.6.19.1 #1)                                                
> EIP is at translate_table+0x600/0xe90                                           
>
> [..]
>
> I've tried to find a subset of the rules that are causing this and I found
> that to be very difficult as I have only got this to fail if I load the
> ebtables rules at boot time, if I try to load them after the machine is
> completely booted it works ok. 2.6.18 still works ok, both kernels have the
> "same" config where posible and they are not SMP.

At what point during boot time do you load your rules? Is networking
already up?

> The machine that was having the failure was a PIII 1GHz, I have copied the
> filesystem to a PIV 1.6Ghz where it also fails and where I can do tests and
> access the console via serial port.
> 
> The machine is not being used as a brouter but only as a bridge firewall, it
> has some ebtables rules to cut non IP stuff and then does all the work at
> iptables level.
> 
> I don't know what other info to add here, tell me if you need any other
> stuff to diagnose this or any testing here.

I'm trying to reproduce this (without success so far), please send your
kernel config and your ebtables script.

You could try if 2.6.19 works, there were some ebtables changes in
2.6.19.1 that touched this code.
