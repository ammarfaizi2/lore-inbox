Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269232AbTGVMvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTGVMvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:51:12 -0400
Received: from holomorphy.com ([66.224.33.161]:1951 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269232AbTGVMvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:51:10 -0400
Date: Tue, 22 Jul 2003 06:07:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Deas, Jim" <James.Deas@warnerbros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc - kmalloc and page locks
Message-ID: <20030722130728.GW15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Deas, Jim" <James.Deas@warnerbros.com>,
	linux-kernel@vger.kernel.org
References: <S270817AbTGVMp3/20030722124529Z+5562@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S270817AbTGVMp3/20030722124529Z+5562@vger.kernel.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 06:00:14AM -0700, Deas, Jim wrote:
> How can I look at what memory are being paged out of memory in the kernel
> or how to lock kmalloc and vmalloc pages so they do not get put to swap?
>  I have a program that runs great 90% of the time but the other 10%
> of the time the system usage (using 'top')goes from 3% to 50% and latency goes out
> the window!  I am assuming this is due to some of my buffers getting swaped 
> out as it often corrects itself and runs well the majority of time.
> Doubling the base memory from 256M to 512M did nothing to fix this.
> I need some way to find out who is holding up the process.
> Any suggestions? linux-newbe did not give me any replys, if
> this is the wrong groups can someone redirect me?

Linux is not a pageable kernel; neither vmalloc() nor kmalloc() return
swappable memory.


-- wli
