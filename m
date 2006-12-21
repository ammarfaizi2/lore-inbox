Return-Path: <linux-kernel-owner+w=401wt.eu-S965049AbWLUO1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWLUO1W (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWLUO1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:27:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50446 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965017AbWLUO1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:27:21 -0500
Date: Thu, 21 Dec 2006 09:27:20 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
In-reply-to: <200612202244.03351.david-b@pacbell.net>
X-X-Sender: nico@xanadu.home
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Message-id: <Pine.LNX.4.64.0612210925130.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200611111541.34699.david-b@pacbell.net>
 <200612201312.36616.david-b@pacbell.net>
 <20061220221252.732f4e97.akpm@osdl.org>
 <200612202244.03351.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, David Brownell wrote:

> On Wednesday 20 December 2006 10:12 pm, Andrew Morton wrote:
> > Why not implement them as inline functions?
> 
> I just collected and forwarded the code from Philip...
> the better not to lose such stuff!  :)
> 
>  
> > Or non-inline functions, come to that.
> 
> In this case I think that'd be preferable; see what those macros
> expand to on pxa27x CPUs.

Only if the gpio argument is not constant please.  When it is constant 
this expands to a single word store.


Nicolas
