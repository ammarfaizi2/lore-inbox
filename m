Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754526AbWKHLMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbWKHLMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbWKHLMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:12:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16049 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1754526AbWKHLMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:12:03 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olson@pathscale.com, akpm@osdl.org
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
	<4550B22C.1060307@serpentine.com>
	<m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
	<4550FB5D.5010804@serpentine.com>
	<m18xim9atv.fsf@ebiederm.dsl.xmission.com>
	<4551679D.9010604@serpentine.com>
Date: Wed, 08 Nov 2006 04:11:07 -0700
In-Reply-To: <4551679D.9010604@serpentine.com> (Bryan O'Sullivan's message of
	"Tue, 07 Nov 2006 21:14:05 -0800")
Message-ID: <m13b8u5h2s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@serpentine.com> writes:

> Eric W. Biederman wrote:
>
>> Ok.  It looks good except you aren't calling ht_destroy_irq on driver unload.
>> Which is a small resource leak.
>
> Yeah, I'm also not reprogramming that register if the interrupt routing changes.
> Ran out of time today.  I'll fix those tomorrow.

Good point.  You generate the value and then never put it anywhere...
Anyway Andrew appears to have the rest of the fixes so this should be
easy to finish.

Eric
