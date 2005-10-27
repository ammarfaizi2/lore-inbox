Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVJ0PqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVJ0PqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVJ0PqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:46:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751109AbVJ0PqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:46:02 -0400
Date: Thu, 27 Oct 2005 08:45:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc5: X spinning in the kernel [ Was: 2.6.14-rc5 GPF in
 radeon_cp_init_ring_buffer()]
In-Reply-To: <1130426711.23729.61.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0510270843100.4664@g5.osdl.org>
References: <Pine.LNX.4.58.0510261103510.24177@skynet> 
 <82b32ed40510262111m2e3b749yca4f78982e879e5e@mail.gmail.com>
 <1130426711.23729.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Oct 2005, Badari Pulavarty wrote:
> 
> sysrq-t shows nothing :(

Use sysrq-p to show register state.

On SMP, you may need to press it several times, to get the right CPU. And 
if you _never_ get the right CPU, that's likely an indication that it 
disabled interrupts, or your platform just sends all keyboard interrupts 
to the same CPU (try to see what happens with interrupt balancing).

		Linus
