Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTH2Cd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTH2Cd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:33:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:51645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264360AbTH2Cd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:33:57 -0400
Message-ID: <32865.4.4.25.4.1062124435.squirrel@www.osdl.org>
Date: Thu, 28 Aug 2003 19:33:55 -0700 (PDT)
Subject: Re: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <davidsen@tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030828220150.466A-100000@gatekeeper.tmr.com>
References: <20030828131019.69a9f3b9.akpm@osdl.org>
        <Pine.LNX.3.96.1030828220150.466A-100000@gatekeeper.tmr.com>
X-Priority: 3
Importance: Normal
Cc: <akpm@osdl.org>, <cswingle@iarc.uaf.edu>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 28 Aug 2003, Andrew Morton wrote:
>
>> Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
>> >
>> > kernel: Unable to handle kernel NULL pointer dereference at virtual
>> address 00000000 ...
>> > kernel: EIP is at find_inode_fast+0x1a/0x60
>> > ...
>> > model name	: AMD Athlon(tm) XP 1800+
>> > ...
>>
>> You've been bitten by the athlon-prefetch(0)-goes-oops problem.
>>
>> Nobody seems to be working this, so I'll be sending the below in to Linus.
>
> Let's not. If this goes in the Athlon users will get bad performance,
> reliable operation, and no one will blame anything but the Athlon... If it
> keeps oopsing hopefully people will complain and it will get fixed.
>
> Taking out features instead of fixing them is a bad president, this is not a
> driver for an obsolete ISA card, this is a performance boost for a very
> current CPU. I'm surprised AMD hasn't looked at it themselves.

Is this the same issue as
  http://marc.theaimsgroup.com/?l=linux-kernel&m=106080170017645&w=2
in which AMD said, "Let us get back to you, ok?" on Aug. 13?

~Randy



