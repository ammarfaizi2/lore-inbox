Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSHUNoT>; Wed, 21 Aug 2002 09:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSHUNoT>; Wed, 21 Aug 2002 09:44:19 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:54693 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S318287AbSHUNoS>; Wed, 21 Aug 2002 09:44:18 -0400
Date: Wed, 21 Aug 2002 07:48:21 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
In-Reply-To: <9EFD49E2FB59D411AABA0008C7E675C009D8DF56@emss04m10.ems.lmco.com>
Message-ID: <Pine.LNX.4.44.0208210739220.8264-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Reed, Timothy A wrote:

> Anyone,
> 
> Can anyone lead me to a good source of information on what options should be
> in the kernel for hyperthreading??  I am still fighting with a
> sub-contractor over kernel options.

As long as you have a P4 and use the P4 support you will get
hyperthreading with 2.4.19 (CONFIG_MPENTIUM4=y).  2.4.18 you have to also 
turn it on with a lilo option of acpismp=force on the kernel command line.

You might want to balance IRQs across the cpus.  Ingo Molnar has created
patches for this, which I've put on my website
at http://www.hardrock.org/kernel/.

hyperthreading will give you some performance boostes, but *only*
if you have many runable processes a majority of the time, or very heavily
threaded applications running on the system.  (an example would
be running 4 setiathome clients on a dual processor system).

regards
James Bourne

> Tim 
> 
> timothy.a.reed@lmco.com

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."



