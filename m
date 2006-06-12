Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752056AbWFLPqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbWFLPqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWFLPqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:46:54 -0400
Received: from mail.suse.de ([195.135.220.2]:21384 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752056AbWFLPqx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:46:53 -0400
From: Andi Kleen <ak@suse.de>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: Using netconsole for debugging suspend/resume
Date: Mon, 12 Jun 2006 17:46:34 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
References: <44886381.9050506@goop.org> <200606121321.30388.ak@suse.de> <448D8A90.3040508@rtr.ca>
In-Reply-To: <448D8A90.3040508@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606121746.34880.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 17:38, Mark Lord wrote:
> Andi Kleen wrote:
> > On Friday 09 June 2006 17:24, Mark Lord wrote:
> >> Andi Kleen wrote:
> >>> If your laptop has firewire you can also use firescope.
> >>> (ftp://ftp.suse.com/pub/people/ak/firescope/) 
> >> ..
> >>> FW keeps running as long as nobody resets the ieee1394 chip.
> >> This looks interesting.  But how does one set it up for use
> >> on the *other* end of that firewire cable?  The Quickstart and
> >> manpage don't seem to describe this fully.
> > 
> > It's in the manpage:
> > 
> >> .SH NOTES
> >> The target must have the ohci1394 driver loaded. This implies
> >> that firescope cannot be used in early boot.
> > 
> > That's it.
> 
> Okay, so I'm daft.  But.. *what* is "it" ??
> 
> We have two machines:  target (being debugged), and host (anything).
> Sure, the target has to have ohci1394 loaded, and firescope running.
> But what about the *other* end of the connection?  What commands?

>From the same manpage:
"The raw1394 module must be loaded and its device node
 be writable (this normally requires root)" 

Ok it doesn't say you need ohci1394 too and doesn't say that's the target.
If I do a new revision I'll perhaps expand the docs a bit.

So load ohci1394/raw1394 and run firescope as root. Your distribution
will hopefully take care of the device nodes. Usually you want 
something like firescope -Au System.map  

-Andi


>
