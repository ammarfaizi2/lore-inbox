Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbUKVBXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUKVBXz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUKVBXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:23:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43447 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261881AbUKVBXx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:23:53 -0500
Date: Sun, 21 Nov 2004 19:01:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: Len Brown <len.brown@intel.com>, David Shaohua <shaohua.li@intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.28 breaks lm_sensors
Message-ID: <20041121210111.GC23689@logos.cnet>
References: <20041120114141.3e0f5f47.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120114141.3e0f5f47.khali@linux-fr.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 20, 2004 at 11:41:41AM +0100, Jean Delvare wrote:
> Hi Marcelo, hi all,
> 
> We have been having reports that recent changes in the ACPI subsystem of
> the Linux 2.4 kernel are breaking lm_sensors on a fairly large number of
> systems. In particular, 2.4.28 is affected.
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1761
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1819
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1820
> 
> I did not report earlier because I thought the problem would be fixed by
> the ACPI folks before 2.4.28 would be released. Unfortunately it wasn't.

Ouch :(

> The problem is already known, was reported for 2.6 kernels 4 months ago
> and fixed there by David Shaohua. See this kernel bug report for the
> detail of symptoms and the solution:
> http://bugzilla.kernel.org/show_bug.cgi?id=3049
> 
> Applying the proposed patch to a 2.4.28 kernel make lm_sensors work
> again on affected systems, while not causing trouble to unaffected ones
> as far as I can tell.
> 
> Len, David, any reason not to apply the same fix to the 2.4 tree?

It looks like this should come through the acpi BK tree. Len, David?

