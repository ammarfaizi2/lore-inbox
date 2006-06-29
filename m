Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWF2SGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWF2SGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWF2SGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:06:00 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:55378 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751221AbWF2SF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:05:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=WKsXo68UivrLndDZZjFQxDC+UqJp3FeEuBoBXKoW5sN2zQ+7ygYmjayIbBVbVGJv2ZVwf74QoMwud53unKmBxgoWt8V/TEjlyULLVFvoRf7Uhc67JVjTtQM4tYEwrNynVuZc99L6rDH9e1zJpENJ7D6SJIG0XtzH1a0aiUL32F8=  ;
Message-ID: <44A41682.90601@yahoo.com.au>
Date: Fri, 30 Jun 2006 04:05:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, akpm@osdl.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu> <20060629094408.360ac157.pj@sgi.com>
In-Reply-To: <20060629094408.360ac157.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>You're probably correct on that model. However, it all depends on the actual
>>workload. Are people who actually have large-CPU (>256) systems actually
>>running fork()-heavy things like webservers on them, or are they running things
>>like database servers and computations, which tend to have persistent
>>processes?
> 
> 
> It may well be mostly as you say - the large-CPU systems not running
> the fork() heavy jobs.
> 
> Sooner or later, someone will want to run a fork()-heavy job on a
> large-CPU system.  On a 1024 CPU system, it would apparently take
> just 14 exits/sec/CPU to hit this bottleneck, if Jay's number of
> 14000 applied.

Half the CPUs in that system are probably going to be several
router hops away, won't they? I'll take a guess and say they're
an order of magnitude too optimistic for such a system ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
