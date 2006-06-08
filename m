Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWFHUkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWFHUkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWFHUkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:40:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:10988 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964991AbWFHUkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:40:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Using netconsole for debugging suspend/resume
Date: Thu, 8 Jun 2006 22:40:31 +0200
User-Agent: KMail/1.9.3
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
References: <44886381.9050506@goop.org>
In-Reply-To: <44886381.9050506@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606082240.31473.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 19:50, Jeremy Fitzhardinge wrote:
> I've been trying to get suspend/resume working well on my new laptop.  
> In general, netconsole has been pretty useful for extracting oopses and 
> other messages, but it is of more limited help in debugging the actual 
> suspend/resume cycle.  The problem looks like the e1000 driver won't 
> suspend while netconsole is using it, so I have to rmmod/modprobe 
> netconsole around the actual suspend/resume.
> 
> This is a big problem during resume because the screen is also blank, so 
> I get no useful clue as to what went wrong when things go wrong.  I'm 
> wondering if there's some way to keep netconsole alive to the last 
> possible moment during suspend, and re-woken as soon as possible during 
> resume.  It would be nice to have a clean solution, but I'm willing to 
> use a bletcherous hack if that's what it takes.
> 
> Any ideas?

Please try doing "echo 8 > /proc/sys/kernel/printk" before suspend.

Greetings,
Rafael
