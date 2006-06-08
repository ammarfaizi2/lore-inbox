Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWFHUgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWFHUgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWFHUgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:36:03 -0400
Received: from fmr18.intel.com ([134.134.136.17]:43226 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S964984AbWFHUgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:36:02 -0400
Message-ID: <44888A10.4010207@intel.com>
Date: Thu, 08 Jun 2006 13:35:28 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060601)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
References: <44886381.9050506@goop.org>
In-Reply-To: <44886381.9050506@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
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

Have you tried using different cards/drivers? This might or might not be 
either a netconsole problem (generic) or driver related (which could impact 
other drivers too).

 From the top of my head I don't see any reason why the e1000 shouldn't handle 
the suspend event - but mind you that a fix for e1000/WoL impacting shutdown 
handlers was only recently added. Which kernels does this impact?

Auke

