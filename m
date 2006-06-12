Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWFLVZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWFLVZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWFLVZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:25:56 -0400
Received: from gw.goop.org ([64.81.55.164]:38067 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932346AbWFLVZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:25:54 -0400
Message-ID: <448DDBD9.6030900@goop.org>
Date: Mon, 12 Jun 2006 14:25:45 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Mark Lord <lkml@rtr.ca>, Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
References: <44886381.9050506@goop.org> <200606121321.30388.ak@suse.de> <448D8A90.3040508@rtr.ca> <200606121746.34880.ak@suse.de>
In-Reply-To: <200606121746.34880.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 12 June 2006 17:38, Mark Lord wrote:
>   
>> Okay, so I'm daft.  But.. *what* is "it" ??
>>
>> We have two machines:  target (being debugged), and host (anything).
>> Sure, the target has to have ohci1394 loaded, and firescope running.
>> But what about the *other* end of the connection?  What commands?
>>     
>
> From the same manpage:
> "The raw1394 module must be loaded and its device node
>  be writable (this normally requires root)" 
>
> Ok it doesn't say you need ohci1394 too and doesn't say that's the target.
> If I do a new revision I'll perhaps expand the docs a bit.
>
> So load ohci1394/raw1394 and run firescope as root. Your distribution
> will hopefully take care of the device nodes. Usually you want 
> something like firescope -Au System.map  
>   

I think the confusion here is that the target doesn't need to be running 
anything; you can DMA chunks of memory with the OHCI controller with no 
need for any software support.  The debugger host is what's running 
firescope.

Unless I'm confused too, which is likely.  Andi, I think your docs 
should be more explicit about what runs where.

Also, the tricky bit for me is debugging resume; firescope still 
requires the OHCI device to come up to be useful, but I that's no 
different from using netconsole.

Neat stuff; I need to get my two firewire-enabled machines close enough 
to each other to try it out.

    J
