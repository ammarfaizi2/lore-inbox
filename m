Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTLHVCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTLHVCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:02:17 -0500
Received: from holomorphy.com ([199.26.172.102]:52701 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263645AbTLHVCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:02:14 -0500
Date: Mon, 8 Dec 2003 13:02:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Per Andreas Buer <perbu@linpro.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
Message-ID: <20031208210201.GP8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Per Andreas Buer <perbu@linpro.no>, linux-kernel@vger.kernel.org
References: <1070897058.25490.56.camel@netstat.linpro.no> <20031208153641.GJ8039@holomorphy.com> <1070898870.25490.76.camel@netstat.linpro.no> <20031208162214.GW19856@holomorphy.com> <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no> <20031208202229.GO8039@holomorphy.com> <1070917304.1260.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070917304.1260.44.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 21:22, William Lee Irwin III wrote:
>> It could potentially slow it down a lot more than a few percent.
>> The main effect you would see is heavy low memory consumption (LowFree:
>> going down to almost nothing) and very heavy cpu consumption.

On Mon, Dec 08, 2003 at 10:01:45PM +0100, Per Andreas Buer wrote:
> Right on. LowFree drops and when it reaches almost nothing the system
> more or less goes freezes. 
> The DAC960 driver is not a SCSI driver so this means that there is
> something wrong with the PCI-DMA transfers, right?
> Replacing the DAC960 with another RAID-kontroller will not help because
> it will use the same PCI-DMA transfers, right? Any hints on how I can
> mend this?

Actually, this suggests lowmem starvation due to bounce buffering.


-- wli
