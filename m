Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTLHVgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLHVgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:36:47 -0500
Received: from holomorphy.com ([199.26.172.102]:56541 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261812AbTLHVgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:36:46 -0500
Date: Mon, 8 Dec 2003 13:36:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Per Andreas Buer <perbu@linpro.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
Message-ID: <20031208213639.GB19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Per Andreas Buer <perbu@linpro.no>, linux-kernel@vger.kernel.org
References: <1070897058.25490.56.camel@netstat.linpro.no> <20031208153641.GJ8039@holomorphy.com> <1070898870.25490.76.camel@netstat.linpro.no> <20031208162214.GW19856@holomorphy.com> <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no> <20031208202229.GO8039@holomorphy.com> <1070917304.1260.44.camel@localhost.localdomain> <20031208210201.GP8039@holomorphy.com> <1070918737.1260.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070918737.1260.62.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 22:02, William Lee Irwin III wrote:
>> Actually, this suggests lowmem starvation due to bounce buffering.

On Mon, Dec 08, 2003 at 10:25:37PM +0100, Per Andreas Buer wrote:
> The kernel is compiled with CONFIG_HIGHIO=y. Do you know if this is a
> DAC960 issue or a chipset issue?

It uses blk_init_queue() and so gets default bouncing behavior of
bouncing everything not in kernel virtualspace; blk_queue_bounce_limit()
would describe the device's actual limits to the system. I don't know
what they are offhand, though, so I can't tell you what to try.


-- wli
