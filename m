Return-Path: <linux-kernel-owner+w=401wt.eu-S965352AbXAKJc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965352AbXAKJc1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 04:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965350AbXAKJc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 04:32:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965349AbXAKJcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 04:32:25 -0500
Message-ID: <45A603FD.9090105@redhat.com>
Date: Thu, 11 Jan 2007 04:31:41 -0500
From: Chris Snook <csnook@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] atl1: Build files for Attansic L1 driver
References: <20070111004051.GB2624@osprey.hogchain.net> <20070111091913.GA3141@infradead.org>
In-Reply-To: <20070111091913.GA3141@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Jan 10, 2007 at 06:40:51PM -0600, Jay Cliburn wrote:
>> --- /dev/null
>> +++ b/drivers/net/atl1/Makefile
>> @@ -0,0 +1,30 @@
>> +################################################################################
>> +#
>> +# Attansic L1 gigabit ethernet driver
>> +# Copyright(c) 2005 - 2006 Attansic Corporation.
>> +#
>> +# This program is free software; you can redistribute it and/or modify it
>> +# under the terms and conditions of the GNU General Public License,
>> +# version 2, as published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope it will be useful, but WITHOUT
>> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> +# more details.
>> +#
>> +# You should have received a copy of the GNU General Public License along with
>> +# this program; if not, write to the Free Software Foundation, Inc.,
>> +# 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> +#
>> +# The full GNU General Public License is included in this distribution in
>> +# the file called "COPYING".
>> +#
>> +################################################################################
> 
> I don't think anyone can claim copyright on two lines of actual kbuild code.
> 
>> +#
>> +# Makefile for the Attansic L1 gigabit ethernet driver
>> +#
> 
> This comment is antirely superflous.
> 
>> +obj-$(CONFIG_ATL1) += atl1.o
>> +
>> +atl1-objs := atl1_main.o atl1_hw.o atl1_ethtool.o atl1_param.o
> 
> Thi should be atl1-y += ...
> 
> In short the whole contents of this file should be:
> 
> ---------------- snip ----------------
> obj-$(CONFIG_ATL1)	+= atl1.o
> atl1-y			+= atl1_main.o atl1_hw.o atl1_ethtool.o atl1_param.o
> ---------------- snip ----------------
> 

Good point.  The original Attansic driver had a whole bunch of legacy 
compat crap, documentation build targets left over from e1000, etc. 
which we've been modifying and mostly just removing.  We don't really 
need this for merging.  If Attansic wants to maintain something out of 
tree for legacy kernels, they might want to reinsert this, but we really 
don't need it.

Thanks for pointing this out.

	-- Chris
