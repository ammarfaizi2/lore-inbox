Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263336AbVGOQyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbVGOQyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbVGOQyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:54:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65458 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263336AbVGOQyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:54:18 -0400
Date: Fri, 15 Jul 2005 17:56:16 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>, Daniel McNeil <daniel@osdl.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
Message-ID: <20050715165616.GH16877@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Badari Pulavarty <pbadari@us.ibm.com>, Tejun Heo <htejun@gmail.com>,
	Daniel McNeil <daniel@osdl.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net> <42D70318.1000304@gmail.com> <42D74724.8000703@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D74724.8000703@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:18:28PM -0700, Badari Pulavarty wrote:
> I can imagine a reason for relaxing the alignment. I keep getting asked
> whether we can do "O_DIRECT mount option".  Database folks wants to
> make sure all the access to files in a given filesystem are O_DIRECT

	All currently existing "O_DIRECT mount option" implementations
that I know of do:

	if (not-512-aligned)
		bounce_buffer()

That is, no one attempts to support the wacky variations in DMA engines.

Joel

-- 

 Brain: I shall pollute the water supply with this DNAdefibuliser,
        turning everyone into mindless slaves.
 Pinky: What about the people who drink bottled water?
 Brain: Pinky, people who pay 5 dollars for a bottle of water are
        already mindless slaves.

			http://www.jlbec.org/
			jlbec@evilplan.org
