Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUIFKn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUIFKn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 06:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUIFKn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 06:43:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32782 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267502AbUIFKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 06:43:25 -0400
Date: Mon, 6 Sep 2004 11:43:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux serial console patch
Message-ID: <20040906114321.A26906@flint.arm.linux.org.uk>
Mail-Followup-To: Danny ter Haar <dth@ncc1701.cistron.net>,
	linux-kernel@vger.kernel.org
References: <20040905175037.O58184@cus.org.uk> <413BA35C.8080705@superbug.demon.co.uk> <chhebr$pta$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <chhebr$pta$1@news.cistron.nl>; from dth@ncc1701.cistron.net on Mon, Sep 06, 2004 at 10:32:27AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 10:32:27AM +0000, Danny ter Haar wrote:
> James Courtier-Dutton  <James@superbug.demon.co.uk> wrote:
> >> I have read your posts to lkml containing your serial console flow control
> >> patches firstly for 2.4.x and then for 2.6.x kernels.
> >
> >Does this fix junk being output from the serial console?
> >If one is using Pentium 4 HT, it seems that both CPU cores try to send 
> >characters to the serial port at the same time, resulting in lost 
> >characters as one CPU over writes the output from the other.
> 
> We have multiple P4-HT enabled servers with debian installed & serial
> console enabled (RPB++ ;-) and _i_ have never seen this behaviour.

I don't think this is a serial problem as such, but a problem with the
kernel console subsystem (printk) itself.  Maybe James can provide an
example output to confirm exactly what he's seeing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
