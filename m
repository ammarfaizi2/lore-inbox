Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWE2HFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWE2HFM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWE2HFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:05:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:17302 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750850AbWE2HFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:05:10 -0400
Message-ID: <447A9D28.9010809@opensound.com>
Date: Mon, 29 May 2006 00:05:12 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.2) Gecko/20060404 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>,
       4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
References: <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org> <447A883C.5070604@opensound.com> <1148883077.3291.47.camel@laptopd505.fenrus.org> <20060529005705.C20649@openss7.org>
In-Reply-To: <20060529005705.C20649@openss7.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian F. G. Bidulock wrote:
> Arjan,
> 
> On Mon, 29 May 2006, Arjan van de Ven wrote:
>> external modules shouldn't care, they really really should inherit the
>> cflags from the kernel's makefiles at which point.. the thing is moot.
> 
> Yes, and ultimately the kernel's makefile (if present) are the best
> place to get CFLAGS from.  However, the task of ensuring that the
> correct Makefile is present and that the correct configuration
> information is feeding it (back to .config) is distribution specific
> and not always straightforward.
> 
> --brian
> 
> 


How about external modules that have a kernel dependant part and kernel 
independant part?. Kernel independant part could live in a separate tree and
has its own makefiles.

But regparm requires that ALL parts linked into the module need to have regparm 
defined. So it's another headache to write makefiles for the kernel independant 
part to figure out if the distro support regparm or not.




regards
Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------
