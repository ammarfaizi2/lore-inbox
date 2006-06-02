Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWFBD1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWFBD1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWFBD1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:27:10 -0400
Received: from fallbackmx02.syd.optusnet.com.au ([211.29.133.72]:30097 "EHLO
	fallbackmx02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751188AbWFBD1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:27:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 13:23:43 +1000
User-Agent: KMail/1.9.1
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000001c685ed$31cba1d0$d234030a@amr.corp.intel.com> <200606021304.14819.kernel@kolivas.org>
In-Reply-To: <200606021304.14819.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021323.44225.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 13:04, Con Kolivas wrote:
> Sure, you have the hack lock. Actually we can just trylock and if it fails
> remove it from the sibling_map and go to out_unlock without a separate
> trylock_smt_cpus function entirely...

I mean go to out_unlock if the sibling_map is empty sorry.

-- 
-ck
