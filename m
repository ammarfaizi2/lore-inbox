Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWJCBfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWJCBfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWJCBfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:35:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31692 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965559AbWJCBfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:35:47 -0400
Message-ID: <4521BE6A.8060400@garzik.org>
Date: Mon, 02 Oct 2006 21:35:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Moore, Eric" <Eric.Moore@lsil.com>, Martin Bligh <mbligh@google.com>,
       LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Panic from mptspi_dv_renegotiate_work in 2.6.18-mm2
References: <664A4EBB07F29743873A87CF62C26D703507DA@NAMAIL4.ad.lsil.com>	<20061002163733.610a3c1f.akpm@osdl.org>	<4521AF8D.4050209@garzik.org> <20061002174147.82093f20.akpm@osdl.org>
In-Reply-To: <20061002174147.82093f20.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 02 Oct 2006 20:32:13 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> FWIW, I am seeing precisely this problem, in the latest -git.
> 
> I just sent this to Linus.  Fingers crossed, it'll fix...
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> 54dbc0c9ebefb38840c6b07fa6eabaeb96c921f5 is causing various people's machines
> to fail to map PCI resources.
> 
> Revert it in preparation for addressing the show-APICs-in-/proc/iomem
> requirement in a different manner.
> 
> Cc: Aaron Durbin <adurbin@google.com>
> Cc: Andi Kleen <ak@muc.de>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

ACK, this fixes sata_mv timeouts and mptsas oopsen here.

FWIW, both sata_mv and mptsas are only accessible on this machine after 
applying my PCI domains patchset.

	Jeff


