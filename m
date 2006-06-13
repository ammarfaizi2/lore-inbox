Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932889AbWFMFJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbWFMFJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWFMFJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:09:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63720 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932889AbWFMFJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:09:24 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2 
In-reply-to: Your message of "Tue, 13 Jun 2006 06:56:45 +0200."
             <200606130656.45511.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Jun 2006 15:08:40 +1000
Message-ID: <10021.1150175320@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Tue, 13 Jun 2006 06:56:45 +0200) wrote:
>
>> I have previously suggested a lightweight solution that pins a process
>> to a cpu 
>
>That is preempt_disable()/preempt_enable() effectively
>It's also light weight as much as these things can be.

The difference being that preempt_disable() does not allow the code to
sleep.  There are some places where we want to use cpu local data and
the code can tolerate preemption and even sleeping, as long as the
process schedules back on the same cpu.

