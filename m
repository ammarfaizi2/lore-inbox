Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUJECel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUJECel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUJECel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:34:41 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:59327 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268739AbUJECej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:34:39 -0400
References: <200410050216.i952Gb620657@unix-os.sc.intel.com>
Message-ID: <cone.1096943670.717018.10082.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:activate_task()
Date: Tue, 05 Oct 2004 12:34:30 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W writes:

> Update p->timestamp to "now" in activate_task() doesn't look right
> to me at all.  p->timestamp records last time it was running on a
> cpu.  activate_task shouldn't update that variable when it queues
> a task on the runqueue.
> 
> This bug (and combined with others) triggers improper load balancing.

The updated timestamp was placed there by Ingo to detect on-runqueue time. 
If it is being used for load balancing then it is being used in error.

Con

