Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947321AbWKKWEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947321AbWKKWEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947322AbWKKWEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:04:50 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:54029 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1947321AbWKKWEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:04:49 -0500
Date: Sat, 11 Nov 2006 22:04:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>, linux-kernel@vger.kernel.org
Subject: Re: ttyS0 not working any more, LSR safety check engaged
Message-ID: <20061111220442.GD28277@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Marc Haber <mh+linux-kernel@zugschlus.de>,
	linux-kernel@vger.kernel.org
References: <20061111114352.GA9206@torres.l21.ma.zugschlus.de> <20061111115016.GA24112@flint.arm.linux.org.uk> <20061111123455.GB9206@torres.l21.ma.zugschlus.de> <20061111153005.GA28277@flint.arm.linux.org.uk> <20061111130656.c9bae39f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111130656.c9bae39f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 01:06:56PM -0800, Andrew Morton wrote:
> /proc/ioports and /proc/iomem might contain hints - can we see those please?

Only if someone is diddling with the resource system by using
insert_resource().  Serial keeps the port claimed as busy all the
time the port is registered with it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
