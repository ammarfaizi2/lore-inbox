Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbTFNF1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 01:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265623AbTFNF1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 01:27:40 -0400
Received: from sj-core-3.cisco.com ([171.68.223.137]:62857 "EHLO
	sj-core-3.cisco.com") by vger.kernel.org with ESMTP id S265620AbTFNF1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 01:27:35 -0400
Message-Id: <5.1.0.14.2.20030614114755.036abbb0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 14 Jun 2003 11:52:53 +1000
To: Anton Blanchard <anton@samba.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: e1000 performance hack for ppc64 (Power4)
Cc: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
       hdierks@us.ibm.com, scott.feldman@intel.com, dwg@au1.ibm.com,
       linux-kernel@vger.kernel.org, milliner@us.ibm.com, ricardoz@us.ibm.com,
       twichell@us.ibm.com, netdev@oss.sgi.com
In-Reply-To: <20030613231836.GD32097@krispykreme>
References: <20030613.154634.74748085.davem@redhat.com>
 <OF0078342A.E131D4B1-ON85256D44.0051F7C0@pok.ibm.com>
 <1055521263.3531.2055.camel@nighthawk>
 <20030613223841.GB32097@krispykreme>
 <20030613.154634.74748085.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:18 AM 14/06/2003 +1000, Anton Blanchard wrote:

> > Not really... one retransmit and the TCP header size grows
> > due to the SACK options.
>
>OK scratch that idea.

why not have a performance option that is a tradeoff between optimum 
payload size versus efficiency.

unless i misunderstand the problem, you can certainly pad the TCP options 
with NOPs ...

> > I find it truly bletcherous what you're trying to do here.
>
>I think so too, but its hard to ignore ~100Mbit/sec in performance.

another option is for the write() path is for instantant-send TCP sockets 
to delay the copy_from_user() until the IP+TCP header size is known.
i wouldn't expect the net folks to like that, however ..


cheers,

lincoln.

