Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVELMvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVELMvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVELMva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:51:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:22751 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261858AbVELMvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:51:12 -0400
Date: Thu, 12 May 2005 14:51:10 +0200
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: alexn@telia.com, ak@suse.de, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050512125110.GJ15690@wotan.suse.de>
References: <s2835ea9.090@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2835ea9.090@emea1-mh.id2.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 02:48:26PM +0200, Jan Beulich wrote:
> >>> Alexander Nyberg <alexn@telia.com> 12.05.05 12:00:08 >>>
> >tor 2005-05-12 klockan 10:27 +0200 skrev Jan Beulich:
> >> Get the x86-64 watchdog tick calculation into a state where it can also
> >> be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
> >> default (as is already done on i386).
> >
> >Why shouldn't the watchdog be turned on by default? It's an extremely
> >useful debugging aid and it's not like it fires NMIs often (the nmi_hz
> >is far from reality).
> 
> For the so-called LAPIC one (based on performance monitor counters) that's true; that is for AMD boxes. For Intel boxes, which get defaulted to the IOAPIC version, it runs at HZ, and this is in my opinion significant overhead. If the Intel support for LAPIC watchdog was completed, and that used as the default, I would certainly agree to keeping it on by default.


I have Intel performance counter watchdog code in my tree, so that is already
done.

-Andi
