Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTERRBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 13:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTERRBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 13:01:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:35528 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262136AbTERRB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 13:01:29 -0400
Date: Sun, 18 May 2003 10:14:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>
cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <21760000.1053278052@[10.10.2.4]>
In-Reply-To: <20030518165445.GA8978@holomorphy.com>
References: <200305180921.h4I9LdD13274@oboe.it.uc3m.es> <19930000.1053275409@[10.10.2.4]> <20030518163537.GZ8978@holomorphy.com> <1053276543.1300.10.camel@laptop.fenrus.com> <20030518165445.GA8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--William Lee Irwin III <wli@holomorphy.com> wrote (on Sunday, May 18, 2003 09:54:45 -0700):

> At some point in the past, Peter Breuer's attribution was removed from:
>>>>> Here's a before-breakfast implementation of a recursive spinlock. That
>>>>> is, the same thread can "take" the spinlock repeatedly. 
> 
> On Sun, May 18, 2003 at 09:30:17AM -0700, Martin J. Bligh wrote:
>>>> Why?
> 
> On Sun, 2003-05-18 at 18:35, William Lee Irwin III wrote:
>>> netconsole.
> 
> On Sun, May 18, 2003 at 06:49:04PM +0200, Arjan van de Ven wrote:
>> not really.
>> the netconsole issue is tricky and recursive, but recursive locks aren't
>> the solution; that would require a rewrite of the network drivers. It's
>> far easier to solve it by moving the debug printk's instead.
> 
> Yes, there are better ways to fix it. But AIUI this is why some people
> want it (the rest of us just don't want messy locking semantics around).

Right ... to me this just seems to create confusing code for no really 
good reason that I can see right now.

M.

