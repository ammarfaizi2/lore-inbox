Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWCYSDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWCYSDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWCYSDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:03:16 -0500
Received: from rune.pobox.com ([208.210.124.79]:48056 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1750800AbWCYSDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:03:15 -0500
Date: Sat, 25 Mar 2006 12:03:10 -0600
From: Rodney Gordon II <meff@pobox.com>
To: Edouard Gomez <ed.gomez@free.fr>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: 2.6.16-ck1
Message-ID: <20060325180310.GA6050@spherenet.spherevision.org>
Mail-Followup-To: Edouard Gomez <ed.gomez@free.fr>,
	ck@vds.kolivas.org, linux-kernel@vger.kernel.org
References: <200603202145.31464.kernel@kolivas.org> <20060323113118.GA9329@spherenet.spherevision.org> <dvv0ob$nql$1@sea.gmane.org> <20060323223138.GA9305@hassard.net> <e0059s$vud$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0059s$vud$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 07:58:03AM +0100, Edouard Gomez wrote:
> I'll backport again from git. The patch i sent was equivalent to 2.6.16 
> sky2 module, but i see new patches that came in netdev-2.6.
> 
> [PATCH] sky2: more ethtool stats
> [PATCH] sky2 version 1.1
> [PATCH] sky2: handle all error irqs
> [PATCH] sky2: transmit recovery
> [PATCH] sky2: whitespace fixes
> [PATCH] sky2: add MSI support
> [PATCH] sky2: coalescing parameters
> [PATCH] sky2: rework of NAPI and IRQ management
> [PATCH] sky2: drop broken wake on lan support
> [PATCH] sky2: remove support for untested Yukon EC ...
> sky2: truncate oversize packets
> sky2: force early transmit interruptsdiff to current
> sky2: not random enough

For those of us that just want something working now:
Patch up using the latest sk98lin patch generator.. then edit
drivers/net/sk98lin/sky2.c and add this line:

#include "h/skdrv1st.h"
#include "h/skdrv2nd.h"
#include <linux/tcp.h>
#include <linux/ip.h>               <-- ADD THIS

It will build fine and seems to work just fine until syskonnect
releases a new revision

GL

-r

-- 
Rodney "meff" Gordon II               -*-              meff@pobox.com
Systems Administrator / Coder Geek    -*-       Open yourself to OpenSource
