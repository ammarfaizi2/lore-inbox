Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWAMTWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWAMTWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422849AbWAMTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:22:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17459 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1422848AbWAMTWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:22:54 -0500
Date: Fri, 13 Jan 2006 20:24:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: jeff shia <tshxiayu@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: something about disk fragmentation
Message-ID: <20060113192452.GY3945@suse.de>
References: <7cd5d4b40601110501w40bc28f0peb13cdbb082e2b4a@mail.gmail.com> <728201270601110633i2eb8c71dq8a0c23d9e7ad724f@mail.gmail.com> <7cd5d4b40601130158l274a3b19t13f2a58a28cc3819@mail.gmail.com> <728201270601130814k37c31f7bxd04a1fe44213b430@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728201270601130814k37c31f7bxd04a1fe44213b430@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13 2006, Ram Gupta wrote:
> On 1/13/06, jeff shia <tshxiayu@gmail.com> wrote:
> > Where Can I get the io schedulers?
> > Thank you!
> 
> See the documentation under the kernel source tree. The code is
> already there. You need only to select by passing correct kernel
> parameters.
> elevator=       [IOSCHED]
>                         Format: {"as" | "cfq" | "deadline" | "noop"}
>                         See Documentation/block/as-iosched.txt and
>                         Documentation/block/deadline-iosched.txt for details.

It's much more convenient to do it dynamically (and saves you a reboot).
Just do

# echo deadline > /sys/block/dev/queue/scheduler

to switch it at runtime, replace 'dev' with your hard drive name, eg
hda or sda etc.

BTW, that option needs updating, you are supposed to use "anticipatory"
for that scheduler (patch accepted :-).

-- 
Jens Axboe

