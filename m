Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263623AbREYII7>; Fri, 25 May 2001 04:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263624AbREYIIt>; Fri, 25 May 2001 04:08:49 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:21011 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263623AbREYIIm>;
	Fri, 25 May 2001 04:08:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Welch <david.welch@st-edmund-hall.oxford.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: Your message of "Fri, 25 May 2001 08:11:07 +0100."
             <20010525081107.A733@whitehall1-5.seh.ox.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 18:08:35 +1000
Message-ID: <25947.990778115@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 08:11:07 +0100, 
David Welch <david.welch@st-edmund-hall.oxford.ac.uk> wrote:
>Why not use a task gate for the double fault handler points to a 
>per-processor TSS with a seperate stack. This would allow limited recovery
>from a kernel stack overlay.

It is far too late by then.  struct task is at the bottom of the kernel
stack, a stack overflow would corrupt the task data long before the
hardware was involved.

