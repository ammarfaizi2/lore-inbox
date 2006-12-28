Return-Path: <linux-kernel-owner+w=401wt.eu-S1754958AbWL1UMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbWL1UMv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbWL1UMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:12:50 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25048 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958AbWL1UMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:12:50 -0500
Date: Thu, 28 Dec 2006 14:14:17 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] introduce config option to disable DMA zone on i386
In-reply-to: <1167331040.3281.4363.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@kvack.org>
Message-id: <45942599.7040409@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.Nb4Y/frBNPmoag6ZL4pL3qEyDOs@ifi.uio.no>
 <fa.XVmR+7tQ0v2oWVb7eyfQ8pGFhp8@ifi.uio.no> <45940E3F.1050506@shaw.ca>
 <1167331040.3281.4363.camel@laptopd505.fenrus.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> ...but Marcelo's patch doesn't implement anything of that kind....
> In addition, many ISA bus drivers do not use the DMA API *at all*
> currently. If you want to fix them all up, great! But somehow I doubt
> those will get fixed in the next decade.. they've been like this for at
> least half a decade or longer :-)

Point being, if this doesn't already work it's likely a bug even without 
this patch. And drivers that don't use the DMA API should at least be 
allocating memory with GFP_DMA which should fail if that zone doesn't 
contain any memory (and if not, that's likely a bug as well).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

