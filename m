Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWHUUC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWHUUC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWHUUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:02:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50311 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750910AbWHUUC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:02:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, Magnus Damm <magnus.damm@gmail.com>,
       Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	<200608211624.11005.ak@suse.de> <20060821144657.GE9549@in.ibm.com>
	<200608211704.03061.ak@suse.de>
Date: Mon, 21 Aug 2006 14:02:16 -0600
In-Reply-To: <200608211704.03061.ak@suse.de> (Andi Kleen's message of "Mon, 21
	Aug 2006 17:04:03 +0200")
Message-ID: <m1fyfpuabb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Monday 21 August 2006 16:46, Vivek Goyal wrote:
>> On Mon, Aug 21, 2006 at 04:24:10PM +0200, Andi Kleen wrote:
>> > 
>> > > Given the idea of relocatable kernel is floating around I would prefer if
>> > > we are not bounded by the restriction of loading a kernel in lowest 4G.
>> > 
>> > There is already other code that requires this. In fact i don't think it can
>> > be above 40MB currently.
>> >
>> 
>> But I think Eric's prototype patches for relocatable kernel do get over
>> this limitation (Hope I understood the code right). Assuming that relocatable
>> kernel patches will be merged down the line, it would be nice not to be
>> bound by 4G limitation.
>
> He may have fixed the 40MB issue, but I very much doubt he changed the 2GB
> limitation because that would be a major change.

I'm not certain I caught everything but as far as I know I did.
Part of that was by having the code run at a fixed virtual address so
we still live in the last 2GB of the virtual address space.


Eric
