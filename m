Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbUL0Uzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUL0Uzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUL0Uzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:55:48 -0500
Received: from quark.didntduck.org ([69.55.226.66]:29121 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261982AbUL0Uzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:55:44 -0500
Message-ID: <41D076D9.30404@didntduck.org>
Date: Mon, 27 Dec 2004 15:55:53 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Tymm Twillman <ttwillman@penguincomputing.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4, 2.6, i686/athlon and LDT's
References: <41D0668B.206@penguincomputing.com> <1104178937.4187.16.camel@laptopd505.fenrus.org>
In-Reply-To: <1104178937.4187.16.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2004-12-27 at 11:46 -0800, Tymm Twillman wrote:
> 
>>Hi all,
> 
> 
>>It appears that use of the LDT is to speed up context switching between 
>>threads, although I haven't even found especially good references WRT 
>>that.  I have looked through the info in the IA Developers publications 
>>and have whacked my head against Google quite a bit.  However, every bit 
>>of clarity I've found there has been offset by new confuzled bits.
> 
> 
> LDT's are *slow*. That's why glibc will try to avoid using them
> nowadays, and with 2.6 it won't; as for 2.4.. it depends if you use a
> vendor 2.4 it might be able to avoid using LDT's as well.

Using the LDT isn't inherently slower, since the cpu caches the segment 
descriptor regardless of if it came from the GDT or LDT.  Using an LDT 
however consumes kernel memory, which can slow down the system from 
memory pressure if you have many processes/threads using them.

--
				Brian Gerst
