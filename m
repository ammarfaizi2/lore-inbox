Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbTEGHjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 03:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbTEGHjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 03:39:07 -0400
Received: from herculanum.int-evry.fr ([157.159.11.15]:31135 "EHLO
	herculanum.int-evry.fr") by vger.kernel.org with ESMTP
	id S262956AbTEGHjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 03:39:05 -0400
Message-ID: <3EB8BB0B.8040708@ac-creteil.fr>
Date: Wed, 07 May 2003 09:51:39 +0200
From: Yann COLLETTE <yann.collette@ac-creteil.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PLIP Problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to connect a laptop to a my home computer using a PLIP 
connection. On both computers, I've a Linux Mandrake 9.0 with a kernel 
2.4.20.
In /etc/hosts, I have pc.home.org 198.168.0.1 and laptop.home.org 
198.168.0.2
For /etc/hosts.allow and /etc/hosts.deny, I've followed the PLIP-HOWTO 
advices.

I've configured the parport_pc module (for both pc):

insmod parport_pc io=0x378 irq=7

The kernel messages are fine with this configuration.
Then I had the plip module (insmod plip).

On the laptop, I do:

ifconfig plip0 laptop.home.org pointopoint pc.home.org netmask 
255.255.255.255 up
route add -host pc.home.org dev plip0

And on my home computer I do:

ifconfig plip0 pc.home.org pointopoint laptop.home.org netmask 
255.255.255.255 up
route add -host laptop.home.org dev plip0

On the laptop, when I ping the pc, nothing happens and on the pc, when I 
 ping the laptop, nothing happens too.

I don't knwo where I am wrong:
- Maybe my parport in not really bidirectionnal on my laptop (how can I 
now if a parport can communicate ?)
- Maybe there's a problem with the way I configure the plip module (I 
don't known how to dive into the kernel sources to extract informations 
about how to configure a module. There are no information about the plip 
module in the kernel documentation).

Your sincerely,

Yann COLLETTE

