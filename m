Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUE3MeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUE3MeR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUE3MeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:34:17 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17870 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263340AbUE3MeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:34:16 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: keyboard problem with 2.6.6
Date: Sun, 30 May 2004 14:32:45 +0200
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <200405301401.20196.oliver@neukum.org> <xb7isee9kaj.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7isee9kaj.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405301432.45736.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 30. Mai 2004 14:22 schrieb Sau Dan Lee:
> >>>>> "Oliver" == Oliver Neukum <oliver@neukum.org> writes:
> 
>     >> Where it is now possible to move it out of kernel space WITHOUT
>     >> performance problems, why not move it out?
> 
>     Oliver> Two reasons: security and robustness.
> 
>     Oliver> 1. sysreq must work, always work. Ideally you even do the
>     Oliver> dump in hard irq. USB has been modified to support this.
> 
> It  doesn't  always work.   Try  to  compile  'i8042' and  'atkbd'  as
> modules.  rmmod one of them, and voila: SysRq doesn't work anymore.

Yes. Remove the driver for your root fs and, lo, the kernel will panic.
You must not confuse kernel and user space. The notion that drivers
can be compiled into modules is not exactly new. In which context they
run is the all important question.

	Oliver
