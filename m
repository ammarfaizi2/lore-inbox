Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUCOWek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbUCOWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:34:40 -0500
Received: from wingding.demon.nl ([82.161.27.36]:8839 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S262827AbUCOWeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:34:36 -0500
Date: Mon, 15 Mar 2004 23:33:58 +0100
From: rutger@mail.com
To: linux-kernel@vger.kernel.org
Subject: [BUG] P4 HT cpufreq driver doesn't share governor/frequency between siblings
Message-ID: <20040315223358.GA29527@mail.com>
Reply-To: linux-kernel@tux.tmfweb.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small bugreport, Pentium 4 Hyper-Threaded with SMP kernel (2.6.4-bk
from Mar 11) and p4-clockmod module loaded, gives:

# cd /sys/devices/system/cpu
# cat cpu*/cpufreq/scaling_governor 
performance
performance
# echo powersave > cpu1/cpufreq/scaling_governor 
# cat cpu*/cpufreq/scaling_governor
performance
powersave

Shouldn't the cpufreq driver be shared between the siblings?

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
