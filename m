Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWBLX3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWBLX3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWBLX3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:29:30 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:13983 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751073AbWBLX33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:29:29 -0500
Message-ID: <43EFC4CE.3040008@vilain.net>
Date: Mon, 13 Feb 2006 12:29:18 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vasily Averin <vvs@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: swsusp done by migration (was Re: [RFC][PATCH 1/5]
 Virtualization/containers: startup)
References: <43E38BD1.4070707@openvz.org>	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>	<43E3915A.2080000@sw.ru>	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>	 <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>	 <m1hd7condi.fsf@ebiederm.dsl.xmission.com>	 <1139243874.6189.71.camel@localhost.localdomain>	 <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>	<20060208215412.GD2353@ucw.cz>	 <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com>	 <7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com>	 <43EC170C.6090807@vilain.net>  <43EC317C.9090101@sw.ru> <1139625499.12123.41.camel@localhost.localdomain> <43EE1EDE.6040809@sw.ru>
In-Reply-To: <43EE1EDE.6040809@sw.ru>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote:
>>When checkpointing it is important to preserve all state.  If you are
>>doing transparent highly available computing, you need to make sure all
>>system calls get the same answers in the clones.  So you would need to
>>virtualise the entropy pool.
> From my point of view it is important to preserve only all the determinated state.
> Ok, lets we've checkpointed and saved current entropy pool. But we have not any
> guarantee that pool will be in the same state at the moment of first access to
> it after wakeuping. Because a new entropy can change it unpredictable.
> Am I right?

Good point.

In general this comes under the heading of "when doing highly available
computing, ensure each of your computing replicas get exactly the same
inputs and always double-check their outputs".

There are lots of 'inputs' that affect the state of the system; when I
referred to "/dev/random and the system clock", I was figuratively
referring to these.  Others might include timing of disk IO events, for
instance.

I'd rather not discuss this too much; it was intended to be a flippant
"wishful thinking" thought, and is certainly not something I have spent
the necessary time investigating to discuss well :).

Sam.
