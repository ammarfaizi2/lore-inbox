Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWBPVuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWBPVuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWBPVuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:50:25 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:11224 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S932362AbWBPVuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:50:24 -0500
Message-ID: <43F4F397.5000704@nortel.com>
Date: Thu, 16 Feb 2006 15:50:15 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
References: <20060216094130.GA29716@elte.hu> <1140107585.21681.18.camel@localhost.localdomain> <20060216172435.GC29151@elte.hu> <1140111257.21681.26.camel@localhost.localdomain> <20060216202357.GA21415@elte.hu> <Pine.LNX.4.64.0602161229390.30911@dhcp153.mvista.com> <20060216212651.GB25738@elte.hu>
In-Reply-To: <20060216212651.GB25738@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 21:50:17.0372 (UTC) FILETIME=[F984B5C0:01C63342]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> basically, ->futex_offset is not blindly trusted by the kernel either: 
> it's simply used to calculate a "userspace pointer" value, which it then 
> uses in a (secure) get_user() access, to do a FUTEX_WAKEUP. [Note that 
> FUTEX_WAKEUP is already done at do_exit() time via the ->clear_child_tid 
> userspace pointer.] All in one: this is totally safe.

As mentioned by Paul...how do you deal with 32/64 compatibility where 
your pointers are different sizes?

Chris
