Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUHYRgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUHYRgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHYRgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:36:46 -0400
Received: from jade.spiritone.com ([216.99.193.136]:28617 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267235AbUHYRgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:36:45 -0400
Date: Wed, 25 Aug 2004 10:36:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <160770000.1093455399@[10.10.2.4]>
In-Reply-To: <200408251023.32434.ryan@spitfire.gotdns.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408242233.55583.gene.heskett@verizon.net> <150920000.1093445730@[10.10.2.4]> <200408251023.32434.ryan@spitfire.gotdns.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Ryan Cumming <ryan@spitfire.gotdns.org> wrote (on Wednesday, August 25, 2004 10:23:29 -0700):

> On Wednesday 25 August 2004 07:55, Martin J. Bligh wrote:
>> This whole thread makes me think ... if we oops, shouldn't we check if
>> we're holding any spinlocks or semaphores, and just panic the whole
>> machine if so? Not sure how expensive it would be to hold that state,
>> but ...
> 
> On preempt, wouldn't it just be a matter of checking preempt_count?

Spinlocks, with or without preeempt, can probably do something like this.
But I don't think that works for sems.

M.

