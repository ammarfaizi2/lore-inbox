Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752525AbWAFUGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbWAFUGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbWAFUGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:06:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752525AbWAFUGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:06:50 -0500
Date: Fri, 6 Jan 2006 12:06:42 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: command line parsing broken in 2.6.15-git?
Message-ID: <20060106120642.5062482e@dxpl.pdx.osdl.net>
In-Reply-To: <200601052051.46344.dtor_core@ameritech.net>
References: <20060105163922.7806343b@dxpl.pdx.osdl.net>
	<200601052051.46344.dtor_core@ameritech.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006 20:51:46 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Thursday 05 January 2006 19:39, Stephen Hemminger wrote:
> > The command line parsing or psmouse driver is broken now, this
> > makes my mouse go wacky on a KVM. It worked up until the latest
> > git updates (post 2.6.15)
> > 
> > Dmesg output:
> > 
> > Kernel command line: root=/dev/md2 vga=0x31a ro selinux=0 psmouse.proto=bare
> > Unknown boot option `psmouse.proto=bare': ignoring
> > 
> 
> Stephen,
> 
> I don't know about parameter parsing but if you could test the patch
> below I'd appreciate it - it deals with resynchronizing PS/2 mouse and
> should help with KVMs.
> 
> Thanks!
> 

Thanks that does fix the KVM mouse screwup, but the module param issue still needs fixing.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
