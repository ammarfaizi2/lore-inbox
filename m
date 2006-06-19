Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWFSVoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWFSVoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWFSVoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:44:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964911AbWFSVoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:44:44 -0400
Date: Mon, 19 Jun 2006 17:44:40 -0400
From: Dave Jones <davej@redhat.com>
To: 7eggert@gmx.de
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060619214440.GA14681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, 7eggert@gmx.de,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	linux-kernel@vger.kernel.org
References: <6pxs2-1AR-5@gated-at.bofh.it> <6pyer-2Pt-1@gated-at.bofh.it> <E1FsRUZ-0001Ll-0K@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FsRUZ-0001Ll-0K@be1.lrz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:40:46PM +0200, Bodo Eggert wrote:
 > linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
 > > On Mon, 19 Jun 2006, Andreas Mohr wrote:
 > 
 > >> while looking for loop places to apply cpu_relax() to, I found the
 > >> following gems:
 > >>
 > >> arch/i386/kernel/crash.c/crash_nmi_callback():
 > >>
 > >>        /* Assume hlt works */
 > >>        halt();
 > >>        for(;;);
 > >>
 > >>        return 1;
 > >> }
 > 
 > This will result in the processor burning energy again after the first
 > interrupt, won't it?

Interrupts are disabled here.

		Dave

-- 
http://www.codemonkey.org.uk
