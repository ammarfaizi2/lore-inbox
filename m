Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWF1H4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWF1H4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWF1H4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:56:18 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:45585 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030468AbWF1H4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:56:17 -0400
Date: Wed, 28 Jun 2006 09:55:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu_up not called for boot cpu
Message-ID: <20060628075522.GB9452@osiris.boeblingen.de.ibm.com>
References: <8054.1151466063@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8054.1151466063@kao2.melbourne.sgi.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 01:41:03PM +1000, Keith Owens wrote:
> cpu_up() is only called for secondary cpus, not for the boot cpu.  That
> means that code hooked into the cpu_chain notifier never gets called
> for the boot cpu, which prevents additional subsystems from taking
> action for the boot cpu.  So how are additional subsystems meant to be
> initialised for the boot cpu?

Looks like you need to add your subsystem's call to do_pre_smp_initcalls().
