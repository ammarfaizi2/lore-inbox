Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVCOPxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVCOPxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVCOPxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:53:05 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:17301 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261342AbVCOPxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:53:02 -0500
Message-ID: <423704B1.8070207@nortel.com>
Date: Tue, 15 Mar 2005 09:52:17 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: Christoph Lameter <clameter@sgi.com>, Matt Mackall <mpm@selenic.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>	 <20050313004902.GD3163@waste.org>	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>	 <20050314192918.GC32638@waste.org>	 <1110829401.30498.383.camel@cog.beaverton.ibm.com>	 <20050314195110.GD32638@waste.org>	 <1110830647.30498.388.camel@cog.beaverton.ibm.com>	 <20050314202702.GF32638@waste.org> <1110852973.1967.180.camel@cube>	 <Pine.LNX.4.58.0503141920460.16054@schroedinger.engr.sgi.com> <1110900235.7893.207.camel@cube>
In-Reply-To: <1110900235.7893.207.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> I know it works for PowerPC. You'll need an isync instruction
> of course. You may also want a sync instruction and some code
> to invalidate the cache.

For PPC you'll want to flush the dcache, then invalidate the icache. 
This will ensure that it works on all processors.

Chris
