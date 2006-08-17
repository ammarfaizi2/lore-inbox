Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWHQTB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWHQTB3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHQTB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:01:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5538 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932578AbWHQTB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:01:28 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: vatsa@in.ibm.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E476DE.4050903@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>
	 <20060817110913.GB19127@in.ibm.com>  <44E476DE.4050903@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Thu, 17 Aug 2006 11:59:15 -0700
Message-Id: <1155841155.26155.1.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 18:02 +0400, Kirill Korotaev wrote:
<snip>
> >>+static void init_beancounter_syslimits(struct user_beancounter *ub)
> >>+{
> >>+	int k;
> >>+
> >>+	for (k = 0; k < UB_RESOURCES; k++)
> >>+		ub->ub_parms[k].barrier = ub->ub_parms[k].limit;
> > 
> > 
> > This sets barrier to 0. Is this value of 0 interpreted differently by
> > different controllers? One way to interpret it is "dont allocate any
> > resource", other way to interpret it is "don't care - give me what you
> > can" (which makes sense for stuff like CPU and network bandwidth).
> every patch which adds a resource modifies this function and sets
> some default limit. Check: [PATCH 5/7] UBC: kernel memory accounting (core)

The idea of upper layer code changing the lower layer's code doesn't
sound good. May be you can think of defining some interface to do it.

> 
> Thanks,
> Kirill
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


