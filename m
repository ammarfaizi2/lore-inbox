Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTKQVfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTKQVfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:35:00 -0500
Received: from dclient217-162-71-11.hispeed.ch ([217.162.71.11]:45441 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261965AbTKQVey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:34:54 -0500
Message-ID: <3FB93EF6.807@steudten.com>
Date: Mon, 17 Nov 2003 22:34:46 +0100
From: Thomas Steudten <alpha@steudten.com>
Reply-To: alpha@steudten.com
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: BUG: Kernel Panic: kernel-2.6.0-test9-bk21  for alpha in scsi
 context ll_rw_blk.c
References: <3FB92938.8040906@steudten.com> <87r806d6n6.fsf@student.uni-tuebingen.de>
In-Reply-To: <87r806d6n6.fsf@student.uni-tuebingen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Authenticated-Sender: user thomas from 192.168.1.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On http://steudten.com/alpha/perf.php4 you can read:
See prefetch section:
The Alpha 21264 initiates a prefetch operation by executing one of the load 
instructions as summarized in the table below. Note that the destination 
register is R31 or F31. When used as a source register, R31 and F31 return 
integer zero and floating point zero, respectively. When used as a 
destination register as shown below, R31 and F31 denote the purpose of 
these instructions as a prefetch operation. Earlier Alpha implementations 
ignore these instructions. Some care must be taken as a prefetch with an 
invalid address must be dismissed by firmware and a prefetch can cause an 
alignment trap.

Tom


Falk Hueffner wrote:

> Thomas Steudten <alpha@steudten.com> writes:
> 
> 
>>-> 0xfffffc0000476cb8 <__make_request+152>:        lds     $f31,0(t2)
> 
> 
> The kernel is stupid, this is a prefetch, it should be totally ignored
> if it is faulty. This is already handled for userspace accesses
> IIRC... (I wonder why the PALcode doesn't already do that. Oh well.)
> 

-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?


