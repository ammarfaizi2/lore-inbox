Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWD1QHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWD1QHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWD1QHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:07:22 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:37856 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1030442AbWD1QHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:07:21 -0400
Message-ID: <44523DB5.1050206@free.fr>
Date: Fri, 28 Apr 2006 18:07:17 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
References: <20060427014141.06b88072.akpm@osdl.org> <pan.2006.04.27.15.47.20.688183@free.fr> <20060427180227.GA1404@in.ibm.com>
In-Reply-To: <20060427180227.GA1404@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> On Thu, Apr 27, 2006 at 05:47:25PM +0200, Matthieu CASTET wrote:
> 
> 
> I think it would break on ppc64 as u64 is unsigned long. It should be
> explicitly typecasted to unsigned long long. Same is true for all the
> instances.
On 64 bits platform, unsigned long isn't the same as unsigned long long ?

Do you mean there will be a warning ?
But pnp_printf is a variadic fonction (with no attribute format printf), 
so gcc can't check the arguments type.


Matthieu

PS : according to arch/ppc/Kconfig, ISA (so PNP that depend on ISA) 
could be enable on PPC_PREP or PPC_CHRP [1]. But there are others 64 
bits architecture like ia64 that have ACPI and use PNP.

[1]
Find out whether you have ISA slots on your motherboard.  ISA is the
           name of a bus system, i.e. the way the CPU talks to the other 
stuff
           inside your box.  If you have an Apple machine, say N here; 
if you
           have an IBM RS/6000 or pSeries machine or a PReP machine, say 
Y.  If
           you have an embedded board, consult your board documentation.

