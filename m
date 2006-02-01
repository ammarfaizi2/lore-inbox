Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWBAA7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWBAA7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWBAA7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:59:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751284AbWBAA7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:59:44 -0500
Date: Tue, 31 Jan 2006 19:59:30 -0500
From: Dave Jones <davej@redhat.com>
To: Avuton Olrich <avuton@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060201005930.GR16557@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Avuton Olrich <avuton@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>
References: <20060129144533.128af741.akpm@osdl.org> <3aa654a40601311445t65fc9b6aqf2d565b72ded9c1a@mail.gmail.com> <20060201001940.GM16557@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201001940.GM16557@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 07:19:40PM -0500, Dave Jones wrote:
 > On Tue, Jan 31, 2006 at 02:45:58PM -0800, Avuton Olrich wrote:
 >  > On 1/29/06, Andrew Morton <akpm@osdl.org> wrote:
 >  > >
 >  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
 >  > 
 >  > I'm getting a kernel panic on my Libretto L5 on boot, I don't have a
 >  > serial port on this laptop, I don't have time at the moment to setup
 >  > netconsole, and it doesn't get the full information. Hopefully this
 >  > picture helps a bit:
 >  > 
 >  > http://68.111.224.150:8080/P1010306.JPG
 >  > 
 >  > If it doesn't help I will attempt to get a netconsole on this computer
 >  > on the near future.
 > 
 > Thomas recently changed cpufreq_update_policy to call cpufreq_out_of_sync()
 > to resync when the BIOS changed the frequency behind our back.
 > The div by 0 trace fingers that code, but I'm puzzled what we're actually
 > dividing there.

it'd be interesting to see the output of cpufreq.debug=7 to see
what adjust_jiffies is getting before we div by 0, though I fear
it'll scroll off the screen before we get a chance to capture it.

		Dave

