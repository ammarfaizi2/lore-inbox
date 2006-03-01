Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWCAAx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWCAAx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWCAAx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:53:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42467 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932740AbWCAAx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:53:56 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<200602282334.05360.rjw@sisk.pl>
	<20060228154805.1f1ed781.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 17:52:15 -0700
In-Reply-To: <20060228154805.1f1ed781.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 28 Feb 2006 15:48:05 -0800")
Message-ID: <m11wxnc7gg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> writes:

> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>>
>> On Tuesday 28 February 2006 13:24, Andrew Morton wrote:
>> 
>> usbcore: registered new driver usbserial
>> usbserial: USB Serial support registered for generic
>> usbcore: registered new driver usbserial_generic
>> usbserial: USB Serial Driver core
>> BUG: warning at kernel/fork.c:113/__put_task_struct()
>> 
>> Call Trace: <IRQ> <ffffffff80229c2b>{__put_task_struct+59}
>> <ffffffff80226f60>{__put_task_struct_cb+16}
> <ffffffff8023faa4>{__rcu_process_callbacks+340}
>> <ffffffff8023fb47>{rcu_process_callbacks+23}
> <ffffffff80231fa8>{tasklet_action+72}
>> <ffffffff802322e4>{__do_softirq+84} <ffffffff8020abae>{call_softirq+30}
>>        <ffffffff8020c7d4>{do_softirq+52} <ffffffff8023215f>{irq_exit+63}
>> <ffffffff8020c781>{do_IRQ+65} <ffffffff8020a232>{ret_from_intr+0} <EOI>
>> BUG: warning at kernel/fork.c:114/__put_task_struct()
>> 
>> ...
> I'd be suspecting the /proc patches.   Can you send the .config please?

Yes this does feel like something got the reference counting of task structures
incorrect.  And I touched a lot of reference counting.  I will look into this
and see if I can find a culprit.


Eric
