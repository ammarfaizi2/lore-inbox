Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUIVRpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUIVRpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUIVRpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:45:49 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:41390 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S266003AbUIVRpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:45:46 -0400
Message-ID: <4151BA3F.8040406@drzeus.cx>
Date: Wed, 22 Sep 2004 19:45:35 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MMC compatibility fix - GO_IDLE
References: <414C065A.7000602@drzeus.cx> <20040922151735.D2347@flint.arm.linux.org.uk>
In-Reply-To: <20040922151735.D2347@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sat, Sep 18, 2004 at 11:56:42AM +0200, Pierre Ossman wrote:
>  
>
>>This patch adds a GO_IDLE before sending a new SEND_OP_COND (as required 
>>by MMC standard).
>>    
>>
>
>Thanks; I haven't completely vanished off the face of the planet.
>  
>
Good to know. You've seemed a bit busy :)

>We already have a function using MMC_GO_IDLE_STATE, so I suggest we
>separate this out.  If you need a 1ms delay after sending this, maybe
>the other case also needs this delay as well?
>
>  
>
The delay was added just in case. The cards I have here work fine 
without it. I just thought adding a small delay might avoid problematic 
cards later on. Seems to be a few of those.

>How about this patch?
>
>  
>
Looks ok. You sure we don't need to put all cards into an idle state 
before issuing a new SEND_OP_COND? I haven't studied how the MMC layer 
is called in detail. Can a rescan be done while a card is in a selected 
state?

Rgds
Pierre

