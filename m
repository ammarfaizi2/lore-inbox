Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVLFKXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVLFKXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVLFKXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:23:45 -0500
Received: from sd291.sivit.org ([194.146.225.122]:3856 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S932539AbVLFKXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:23:44 -0500
Date: Tue, 6 Dec 2005 11:23:40 +0100
From: Luc Saillard <luc@saillard.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jiri Benc <jbenc@suse.cz>, Michael Buesch <mbuesch@freenet.de>,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051206102340.GC24486@sd291.sivit.org>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Jiri Benc <jbenc@suse.cz>, Michael Buesch <mbuesch@freenet.de>,
	linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
	NetDev <netdev@vger.kernel.org>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <200512052123.42357.mbuesch@freenet.de> <20051205214256.492421ad@griffin.suse.cz> <D76B7270-C6A7-4068-9FDD-4C8B9F491F62@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D76B7270-C6A7-4068-9FDD-4C8B9F491F62@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 04:26:50AM -0500, Kyle Moffett wrote:
> On Dec 05, 2005, at 15:42, Jiri Benc wrote:
> >On Mon, 5 Dec 2005 21:23:42 +0100, Michael Buesch wrote:
> >>This is __not__ "yet another stack". It is an _extension_.  It is  
> >>all about management frames, which the in-kernel code does not  
> >>manage.
> >
> >But this code should be part of the stack, as nearly every driver  
> >needs it.
> 
> WRONG.  More than half the currently Linux-compatible wireless cards  
> handle the wireless management packets in hardware, such that they're  
> little more complicated than a basic ethernet device with a channel,  
> an ESSID, and a list of MACs/APs.
> 
 
I do not want to enter in this flamewar, but the current driver i'm working
on (marvell libertas chipset) need management frames in software. But to
reduce cost, i think that lower chipset try to put the most in the host and
not in the chipset. Marvell build the chipset around a ARM cpu so i think one
day i can do it in hardware but for now i need to choose a ieee802.11 stack.
I've began to used the in kernel solution with my own functions to
send and received this frame. But i hope we will find a technical solution
that please everyone. I'll try to see if the softmac layer written for
broadcom driver can be used for my project.

Luc
