Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUAZVcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUAZVcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:32:36 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:48014 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265071AbUAZVcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:32:35 -0500
Date: Mon, 26 Jan 2004 16:17:46 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PNP depends on ISA ? (2.6.2-rc2
Message-ID: <20040126161746.GA3180@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Micha Feigin <michf@post.tau.ac.il>, linux-kernel@vger.kernel.org
References: <20040126193144.GC2004@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126193144.GC2004@luna.mooo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 09:31:44PM +0200, Micha Feigin wrote:
> I was wondering why pnp depends on isa being selected in 2.6.2-rc2, is
> pnp really only relevant to isa? What happens with pci etc. ?
> This may explain why using pnpbios locks up my machine (at least as of 2.6.0-test9).

Yes, it only is related to isa devices, but they include onboard devices
such as serial ports.  It will, however, prevent resource conflicts
between pci and system devices, especially with unusual configurations.
Does using pnpbios cause your machine to lockup at boot?  If so, around
where does it occur?  DMI information would also be useful for blacklisting
purposes.

Thanks,
Adam
