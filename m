Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVBGOLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVBGOLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVBGOLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:11:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54153 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261419AbVBGOLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:11:06 -0500
Message-ID: <42077724.1060606@sgi.com>
Date: Mon, 07 Feb 2005 06:11:48 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: move-accounting-function-calls-out-of-critical-vm-code-paths.patch
References: <20050110184617.3ca8d414.akpm@osdl.org>	<Pine.LNX.4.58.0502031319440.25268@schroedinger.engr.sgi.com>	<20050203140904.7c67a144.akpm@osdl.org>	<Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com> <20050203150551.4d88f210.akpm@osdl.org>
In-Reply-To: <20050203150551.4d88f210.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christoph Lameter <clameter@sgi.com> wrote:
> 
>>I hope that Roland's changes for higher resolution of cputime would
>>make that possible. But this is Jay's thing not mine. I just want to make
>>sure that the CSA patches does not get in the way of our attempts to
>>improve the performance of the page fault handler. In the discussions on
>>linux-mm there was also some concern about adding these calls.
> 
> 
> Well your patch certainly cleans things up in there and would be a good
> thing to have as long as we can be sure that it doesn't break the
> accounting in some subtle way.
> 
> Which implies that we need to see some additional accounting code, so we
> can verify that the base accumulation infrastructure is doing the expected
> thing.  As well as an ack from the interested parties.  Does anyone know
> what's happening with all the new accounting initiatives?  I'm seeing no
> activity at all.

Sorry guys! I have been away for three weeks on short term disability.:(

I have tested Christoph's patch before the leave. It did work for CSA
and showed performance improvement on certain configuration.

CSA is currently implemented as a loadable module. I think ELSA is the
same, right? The use of the enhanced accounting data collection
code is not in the kernel tree. That was why Andrew did not see usage of 
the accounting patches. Should i propose to include the CSA module in
the kernel then, Andrew? :)

Cheers,
  - jay


