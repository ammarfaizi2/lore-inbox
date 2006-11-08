Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754523AbWKHLI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbWKHLI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbWKHLI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:08:56 -0500
Received: from 80-218-222-94.dclient.hispeed.ch ([80.218.222.94]:61449 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S1754519AbWKHLIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:08:55 -0500
Message-ID: <4551BABE.1060307@steudten.com>
Date: Wed, 08 Nov 2006 12:08:46 +0100
From: "alpha @ steudten Engineering" <NWQ3MzhlY2QwZDAzODVhN@steudten.com>
Organization: Steudten Engineering
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: INFO alpha CPU: Locking API testsuite: Results kernel 2.6.18.1
References: <20061108093201.GA2489@ff.dom.local>
In-Reply-To: <20061108093201.GA2489@ff.dom.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 404ed6adb598d0f60b9b752914fbdbcd on steudten.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PROVE_LOCKING=y ?

It't not there/set! It depends on:
config PROVE_LOCKING
        bool "Lock debugging: prove locking correctness"
        depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
        select LOCKDEP
so it looks like only DEBUG_KERNEL is set for alpha.
Maybe some dependencies are missing.. I'll check this.

Jarek Poplawski wrote:
> On 04-11-2006 15:27, alpha @ steudten Engineering wrote:
>> kernel-2.6.18.1 ALPHA SX164
>> No "failed" on x86.
>> ------------------------
>> | Locking API testsuite:
>> ----------------------------------------------------------------------------
>>                                  | spin |wlock |rlock |mutex | wsem | rsem |
>>   --------------------------------------------------------------------------
>>                      A-A deadlock:failed|failed|  ok  |failed|failed|failed|
> ...
>> --------------------------------------------------------
>> 143 out of 218 testcases failed, as expected. |
>> ----------------------------------------------------
> 
> CONFIG_PROVE_LOCKING=y ?

