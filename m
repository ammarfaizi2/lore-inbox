Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423870AbWKHXBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423870AbWKHXBL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423869AbWKHXBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:01:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423864AbWKHXBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:01:08 -0500
Date: Wed, 8 Nov 2006 15:00:07 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: tim.c.chen@linux.intel.com
Cc: Olaf Kirch <okir@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, davem@sunset.davemloft.net,
       kuznet@ms2.inr.ac.ru, netdev@vger.kernel.org
Subject: Re: 2.6.19-rc1: Volanomark slowdown
Message-ID: <20061108150007.49eaea68@freekitty>
In-Reply-To: <1163023652.10806.203.camel@localhost.localdomain>
References: <1162924354.10806.172.camel@localhost.localdomain>
	<1163001318.3138.346.camel@laptopd505.fenrus.org>
	<20061108162955.GA4364@suse.de>
	<1163011132.10806.189.camel@localhost.localdomain>
	<20061108221028.GA16889@suse.de>
	<1163023652.10806.203.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 14:07:32 -0800
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On Wed, 2006-11-08 at 23:10 +0100, Olaf Kirch wrote:
> 
> > 
> > In fixing performance issues, the most obvious explanation isn't always
> > the right one. It's quite possible you're right, sure.
> > 
> > What I'm saying though is that it doesn't rhyme with what I've seen of
> > Volanomark - we ran 2.6.16 on a 4p Intel box for instance and it didn't
> > come close to saturating a Gigabit pipe before it maxed out on CPU load.
> > 
> 
> I am running Volanomark in a loopback mode on a 2P woodcrest box 
> (4 cores).  So the configuration is a bit different.  
> 
> In my testing, the CPU utilization is at 100%.  So
> increase in ACKs will cost CPU to devote more
> time to process those ACKs and reduce throughput.
> 
> > 
> > You could count the number of outbound packets dropped on the server.
> > 
> 
> As I'm running in loopback mode, there are no dropped packets.
> 

Optimizing for loopback is perversion; perversion can be fun but it gets
to be a obsession then it's sick.

-- 
Stephen Hemminger <shemminger@osdl.org>
