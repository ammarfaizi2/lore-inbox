Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbTBPMfY>; Sun, 16 Feb 2003 07:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTBPMfY>; Sun, 16 Feb 2003 07:35:24 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:43205 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266643AbTBPMfT>; Sun, 16 Feb 2003 07:35:19 -0500
Date: Sun, 16 Feb 2003 13:37:42 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Link failure with current bk w/o CONFIG_X86_POWERNOW_K6
Message-ID: <20030216123742.GA28689@brodo.de>
References: <3E4F7A0E.30305@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4F7A0E.30305@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 12:46:22PM +0100, Jan Dittmer wrote:
> Happens with CONFIG_X86_POWERNOW_K6 disabled, ie. you cannot enable 
> CONFIG_X86_POWERNOW_K7 w/o enabling CONFIG_X86_POWERNOW_K7.

Using your .config, I can't reproduce this link error - I tested it with
CONFIG_X86_POWERNOW_K7 && CONFIG_X86_POWERNOW_K6
CONFIG_X86_POWERNOW_K7 && !CONFIG_X86_POWERNOW_K6
!CONFIG_X86_POWERNOW_K7 && CONFIG_X86_POWERNOW_K6
!CONFIG_X86_POWERNOW_K7 && !CONFIG_X86_POWERNOW_K6

Might it be that you have some other patch added to the kernel, which causes
a reject for linux/drivers/Makefile?

> Also the indenting in the cpufreq menu seems to be wrong. Shouldn't 
> 'Intel Speedstep', 'Intel Pentium 4', 'Transmeta LongRun' and 'Cyrix 
> MediaGX' be childs of CPU Frequency scaling an indented by 2 spaces?

A patch for this by Marc-Christian Petersen will be on the way soon.

	Dominik
