Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTLHUWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLHUWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:22:37 -0500
Received: from holomorphy.com ([199.26.172.102]:47325 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261967AbTLHUWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:22:36 -0500
Date: Mon, 8 Dec 2003 12:22:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Per Andreas Buer <perbu@linpro.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
Message-ID: <20031208202229.GO8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Per Andreas Buer <perbu@linpro.no>, linux-kernel@vger.kernel.org
References: <1070897058.25490.56.camel@netstat.linpro.no> <20031208153641.GJ8039@holomorphy.com> <1070898870.25490.76.camel@netstat.linpro.no> <20031208162214.GW19856@holomorphy.com> <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
>> If your memory ended at 2GB and the driver had 31-bit DMA, it may have
>> decided to use unconstrained allocations. Then, when you added more RAM,
>> it was forced to ask for <= 896MB, which made it copy to buffers that are
>> actually below 896MB most of the time.

On Mon, Dec 08, 2003 at 09:15:15PM +0100, Per Andreas Buer wrote:
> But this would reduce the throuput only a few percent, right? My system
> slows down from writing ~ 100MB/s to maybe 50KB/s. 

It could potentially slow it down a lot more than a few percent.

The main effect you would see is heavy low memory consumption (LowFree:
going down to almost nothing) and very heavy cpu consumption.


-- wli
