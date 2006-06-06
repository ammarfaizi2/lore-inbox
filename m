Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWFFIdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWFFIdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWFFIdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:33:53 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:52624 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751177AbWFFIdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:33:52 -0400
From: Duncan Sands <baldrick@free.fr>
To: Mick <mick@wow.nailed.org>
Subject: Re: PPPOA - Badness in local_bh_enable at kernel/softirq.c:140
Date: Tue, 6 Jun 2006 10:33:48 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060605115855.2b9f573e@morticia.wow.nailed.org>
In-Reply-To: <20060605115855.2b9f573e@morticia.wow.nailed.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061033.48693.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mick,

> Jun  1 18:38:34 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
> Jun  1 18:38:34 thunderbird1 
> Jun  1 18:38:34 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff8804506f>{:he:he_service_rbrq+1050}
> Jun  1 18:38:34 thunderbird1 <ffffffff88045585>{:he:he_tasklet+163} <ffffffff8013d164>{tasklet_action+101}
> Jun  1 18:38:34 thunderbird1 <ffffffff8013ce10>{__do_softirq+80} <ffffffff80110c5b>{call_softirq+31}
> Jun  1 18:38:34 thunderbird1 <ffffffff80112248>{do_softirq+47} <ffffffff80112114>{do_IRQ+50}
> Jun  1 18:38:34 thunderbird1 <ffffffff8010fe7c>{ret_from_intr+0}  <EOI> <ffffffff8010dc09>{default_idle+0}
> Jun  1 18:38:34 thunderbird1 <ffffffff8010dc3e>{default_idle+53} <ffffffff8010de74>{cpu_idle+143}
> Jun  1 18:38:34 thunderbird1 <ffffffff805f079a>{start_kernel+439} <ffffffff805f0276>{_sinittext+630}

it's not clear to me what's going on.  Can you please disassemble
the function he_service_rbrq.  You can do this by running
	objdump -S drivers/atm/he.o
in the directory containing your kernel source.  Please edit the
result, only keeping the he_service_rbrq routine.

Best wishes,

Duncan.
