Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUCOWoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbUCOWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:44:07 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:4321 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262839AbUCOWlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:41:47 -0500
Date: Mon, 15 Mar 2004 22:41:17 +0000
From: Dave Jones <davej@redhat.com>
To: linux-kernel@tux.tmfweb.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] P4 HT cpufreq driver doesn't share governor/frequency between siblings
Message-ID: <20040315224117.GD19555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, linux-kernel@tux.tmfweb.nl,
	linux-kernel@vger.kernel.org
References: <20040315223358.GA29527@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315223358.GA29527@mail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 11:33:58PM +0100, rutger@mail.com wrote:
 > Small bugreport, Pentium 4 Hyper-Threaded with SMP kernel (2.6.4-bk
 > from Mar 11) and p4-clockmod module loaded, gives:
 > 
 > # cd /sys/devices/system/cpu
 > # cat cpu*/cpufreq/scaling_governor 
 > performance
 > performance
 > # echo powersave > cpu1/cpufreq/scaling_governor 
 > # cat cpu*/cpufreq/scaling_governor
 > performance
 > powersave
 > 
 > Shouldn't the cpufreq driver be shared between the siblings?

Theoretically, as split-cores become more advanced, we will be able
to save power on unused cores.  With the current P4's I'll bet it
makes little to no difference at all.

		Dave

