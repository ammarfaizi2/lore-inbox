Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTLHVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLHVAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:00:25 -0500
Received: from 66.80-203-43.nextgentel.com ([80.203.43.66]:5330 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263488AbTLHVAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:00:20 -0500
Subject: Re: 2.4: mylex and > 2GB RAM
From: Per Andreas Buer <perbu@linpro.no>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031208202229.GO8039@holomorphy.com>
References: <1070897058.25490.56.camel@netstat.linpro.no>
	 <20031208153641.GJ8039@holomorphy.com>
	 <1070898870.25490.76.camel@netstat.linpro.no>
	 <20031208162214.GW19856@holomorphy.com>
	 <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no>
	 <20031208202229.GO8039@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Linpro AS
Message-Id: <1070917304.1260.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 08 Dec 2003 22:01:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 21:22, William Lee Irwin III wrote:
>
> It could potentially slow it down a lot more than a few percent.
> 
> The main effect you would see is heavy low memory consumption (LowFree:
> going down to almost nothing) and very heavy cpu consumption.

Right on. LowFree drops and when it reaches almost nothing the system
more or less goes freezes. 

The DAC960 driver is not a SCSI driver so this means that there is
something wrong with the PCI-DMA transfers, right?

Replacing the DAC960 with another RAID-kontroller will not help because
it will use the same PCI-DMA transfers, right? Any hints on how I can
mend this?

-- 
Per Andreas Buer <perbu@linpro.no>
