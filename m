Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTILBqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTILBqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:46:46 -0400
Received: from evrtwa1-ar2-4-35-048-180.evrtwa1.dsl-verizon.net ([4.35.48.180]:55181
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S261653AbTILBqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:46:45 -0400
Message-ID: <3F612570.1010303@candelatech.com>
Date: Thu, 11 Sep 2003 18:46:24 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dada1 <dada1@cosmosbay.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Network buffer hang was Re: [PATCH] 2.6 workaround for Athlon/Opteron
 prefetch errata
References: <uqD5.3BI.3@gated-at.bofh.it> <m3iso0arlx.fsf@averell.firstfloor.org> <0a5801c37821$54eb8180$890010ac@edumazet> <20030911051121.GA7751@colin2.muc.de> <0a7701c37829$c4bdef40$890010ac@edumazet> <20030911120956.GB7751@colin2.muc.de> <0b2901c37867$1db399a0$890010ac@edumazet>
In-Reply-To: <0b2901c37867$1db399a0$890010ac@edumazet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dada1 wrote:
>>>This is not a kernel crash. But total freeze as all memory is used by
>>>network buffers, in no more than 10 seconds.

I believe I have hit this as well, by starting 500kbps streams on 500
vlans at once.  My machine locks so hard that I have not been able to
get any info out of it...but the realtek driver shows and error message
about not being able to allocate any buffers if I ping it....

I was using kernel 2.4.21 or so, and had tcp buffers turned up
quite high.  I have seen this on P-IV and AMD (single Athlon) systems,
as well as a VIA C3.


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


