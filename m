Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVKERfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVKERfz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVKERfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:35:55 -0500
Received: from mx1.suse.de ([195.135.220.2]:65461 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750851AbVKERfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:35:54 -0500
To: Evgeny Rodichev <er@sai.msu.su>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 mce_log question
References: <Pine.GSO.4.63.0511021822010.28234@ra.sai.msu.su>
From: Andi Kleen <ak@suse.de>
Date: 05 Nov 2005 18:35:53 +0100
In-Reply-To: <Pine.GSO.4.63.0511021822010.28234@ra.sai.msu.su>
Message-ID: <p73k6fn2e12.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeny Rodichev <er@sai.msu.su> writes:

> Hello,
> 
> at Opteron-based x86_64 system sometimes I get message
> 
> Machine check events logged
> 
> (non-fatal). How can I read the correspondent events?

Read the help

config X86_MCE
        bool "Machine check support" if EMBEDDED
        default y
        help
           Include a machine check error handler to report hardware errors.
           This version will require the mcelog utility to decode some
           machine check error logs. See
           ftp://ftp.x86-64.org/pub/linux/tools/mcelog


> From the source
> code (arch/x86_64/kernel/mce.c) it sounds like some misc device with
> MISC_MCELOG_MINOR 227 is registered (with name "mcelog"?), but there is
> no such device under /dev.

Your distribution is broken then. In fact it is supposed to run
mcelog regularly from a cronjob to log machine check events into
a disk log. Complain to them.

-Andi
