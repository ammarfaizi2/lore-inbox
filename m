Return-Path: <linux-kernel-owner+w=401wt.eu-S1422724AbXAMRRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbXAMRRu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 12:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbXAMRRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 12:17:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53300 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422724AbXAMRRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 12:17:49 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 13 Jan 2007 18:16:59 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
To: Richard Knutsson <ricknu-0@student.ltu.se>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <45A9092F.7060503@student.ltu.se>
Message-ID: <tkrat.428a51215926acac@s5r6.in-berlin.de>
References: <45A9092F.7060503@student.ltu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan, Richard Knutsson wrote:
[...]
> SUPERCOOL ALPHA CARD
> 
> P:	Clark Kent
> M:	superman@krypton.kr
> L:	some@thing.com
> C:	SUPER_A
> S:	Maintained
> (C: for CONFIG. Any better idea?)
> 
> then if someone changes a file who are built with CONFIG_SUPER_A, can 
> easily backtrack it to the correct maintainer(s).
[...]
> My first idea was to use the pathway and define that directories above 
> the specified (if not specified by another) would fall to the current 
> maintainer. It would work, but requires that all pathways be specified 
> at once, or a few maintainers with "short" pathways would get much of 
> the patches (and it is not as correct/easy to maintain as looking for 
> the CONFIG_flag).
> 
> 
> Any thoughts on this is very much appreciated (is there any flaws with 
> this?).

 - What about drivers which have no MAINTAINER entry but reside in a
   subsystem with MAINTAINER entry?

 - What if these drivers depend on two subsystems?
 
 - Config options map to object files but do not map directly to source
   files. Diffstats show source files.

Example: The sbp2 driver is an IEEE 1394 driver and a SCSI driver.
sbp2.o is enabled by CONFIG_IEEE1394_SBP2 which depends on
CONFIG_IEEE1394 and CONFIG_SCSI. sbp2.c resides in drivers/ieee1394/.
What is the algorithm to look up sbp2's maintainers?

Don't get me wrong though. Easier lookup of maintainers and mailinglists
sounds to me like a desirable feature, not just from the point of view
of submitters but also of maintainers.
-- 
Stefan Richter
-=====-=-=== ---= -==-=
http://arcgraph.de/sr/

