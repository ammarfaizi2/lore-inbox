Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWFIDql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWFIDql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFIDqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:46:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41103 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932264AbWFIDqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:46:39 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Using netconsole for debugging suspend/resume
Date: Fri, 9 Jun 2006 05:46:15 +0200
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
Message-Id: <200606090546.15923.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 19:50, Jeremy Fitzhardinge wrote:
> I've been trying to get suspend/resume working well on my new laptop.  
> In general, netconsole has been pretty useful for extracting oopses and 
> other messages, but it is of more limited help in debugging the actual 
> suspend/resume cycle.  The problem looks like the e1000 driver won't 
> suspend while netconsole is using it, so I have to rmmod/modprobe 
> netconsole around the actual suspend/resume.

If your laptop has firewire you can also use firescope.
(ftp://ftp.suse.com/pub/people/ak/firescope/) 

> This is a big problem during resume because the screen is also blank, so 
> I get no useful clue as to what went wrong when things go wrong.  I'm 
> wondering if there's some way to keep netconsole alive to the last 
> possible moment during suspend, and re-woken as soon as possible during 
> resume.  It would be nice to have a clean solution, but I'm willing to 
> use a bletcherous hack if that's what it takes.

FW keeps running as long as nobody resets the ieee1394 chip.

Networking is much more complex and will likely never work well for such
low level debug situations. Netconsole is mostly useful to catch the
odd oops during runtime.

-Andi


