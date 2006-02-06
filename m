Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWBFJo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWBFJo1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBFJo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:44:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:65238 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750862AbWBFJo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:44:26 -0500
From: Andi Kleen <ak@suse.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC 4/4] firewire: add mem1394
Date: Mon, 6 Feb 2006 09:44:02 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
References: <1138919238.3621.12.camel@localhost> <p73lkwplfw8.fsf@verdi.suse.de> <43E6650C.1090407@s5r6.in-berlin.de>
In-Reply-To: <43E6650C.1090407@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602060944.03408.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 February 2006 21:50, Stefan Richter wrote:
> Andi Kleen wrote:
> > BenH's firescope tool does this already using raw1394
> > (I have it working now on x86-64 too). I dont quite see the point
> > of adding another kernel driver for it though. This can be all
> > done fine in userspace.
> 
> The point is to provide an interface like /dev/mem in order to use a 
> wider range of debug/ forensics/ hacker tools than specialized 
> libraw1394 clients. 

I don't see the benefit really. It can be as well provided by 
a userspace library 

Many of the debug tools don't even work on /dev/mem, but use
different interfaces (/proc/kcore, gdb remote protocol etc.) 

Also raw1394 could possibly be used to cause interrupts
on the target and also stop the target CPU this way.

-Andi
