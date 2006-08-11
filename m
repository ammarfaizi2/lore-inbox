Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWHKUNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWHKUNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWHKUNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:13:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47069 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932356AbWHKUNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:13:15 -0400
Date: Fri, 11 Aug 2006 16:12:36 -0400
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
Message-ID: <20060811201236.GI26930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <44DCCB96.5080801@rtr.ca> <20060811183954.GH26930@redhat.com> <44DCDD50.4020804@rtr.ca> <44DCE213.8090508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DCE213.8090508@rtr.ca>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 04:01:23PM -0400, Mark Lord wrote:
 > Mark Lord wrote:
 > > Dave Jones wrote:
 > >>
 > >> boot with cpufreq.debug=7, and capture dmesg output after it fails
 > >> to transition.  This might be another manifestation of the mysterious
 > >> "highest frequency isnt accessable" bug, that seems to come from
 > >> some recent change in acpi.
 > > 
 > > booting with that option doesn't seem to give me any new messages
 > > in dmesg (or /var/log/messages).  I also tried editing cpufreq.c
 > > and hardcoding debug = 7 on the variable declaration.
 > > Still no new messages.
 > 
 > Mmm.. that's interesting.. this time, the scaling_max_freq went back up
 > to 1100000 all by itself after a longish idle period, before which it had
 > dropped to 800000 and got "stuck" there.
 > 
 > Currently using the "ondemand" governor -- it doesn't seem to call the
 > central cpufreq_debug_printk() thingie from cpufreq.c.
 > 
 > I did hack cpufreq_debug_printk() to force output anytime it gets called,
 > but still no new output in the logs.

Do you have CONFIG_CPU_FREQ_DEBUG enabled ?

		Dave
-- 
http://www.codemonkey.org.uk
