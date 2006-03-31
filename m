Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWCaI0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWCaI0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCaI0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:26:52 -0500
Received: from mail.axxeo.de ([82.100.226.146]:12680 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1751270AbWCaI0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:26:51 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Date: Fri, 31 Mar 2006 10:26:33 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Grover <andy.grover@gmail.com>,
       "Chris Leech" <christopher.leech@intel.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060329225505.25585.30392.stgit@gitlost.site> <c0a09e5c0603301036s4e9a63e5v476d89ff8ba37760@mail.gmail.com> <351C5BDA-D7E3-4257-B07E-ABDDCF254954@kernel.crashing.org>
In-Reply-To: <351C5BDA-D7E3-4257-B07E-ABDDCF254954@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311026.33391.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> On Mar 30, 2006, at 12:36 PM, Andrew Grover wrote:
> > Well....it's true they're useful for debugging but I would put them in
> > the category of system statistics that shouldn't go in debugfs. I
> > think they are like /proc/interrupts' interrupt counts or the TX/RX
> > stats reported by ifconfig.
> 
> Fair, but wouldn't it be better to have the association per client.
> 
> Maybe leave the one as a summary and have a dir per client with  
> similar stats that are for each client and add a per channel summary  
> at the top level as well.

Such level of detail really belongs to debugging, IMHO.

I think, it would suffer to say, how many channels are in use.
So you can answer the question, whether your customers are actually
using this experimental technology. 

If you want more, let them mount debugfs. 
If it becomes really important, we can revisit this later.

Thats the advantage of files under debugfs 
not being stable API in any way.

BTW: What is the actual frequency, at which such counters 
will be incremented?


Regards

Ingo Oeser
