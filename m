Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTKCKEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 05:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTKCKEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 05:04:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57614 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261868AbTKCKEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 05:04:52 -0500
Date: Mon, 3 Nov 2003 10:04:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: What do frame pointers do?
Message-ID: <20031103100449.A22719@flint.arm.linux.org.uk>
Mail-Followup-To: Bradley Chapman <kakadu_croc@yahoo.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20031102204556.0c5b377a.rddunlap@osdl.org> <20031103092909.4955.qmail@web40907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031103092909.4955.qmail@web40907.mail.yahoo.com>; from kakadu_croc@yahoo.com on Mon, Nov 03, 2003 at 01:29:09AM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 01:29:09AM -0800, Bradley Chapman wrote:
> > Frame pointers enable more deterministic back tracing of the stack,
> > which can be helpful for tracking down bugs.  I build with
> > CONFIG_FRAME_POINTER enabled all of the time.

On ARM, simply scanning the kernel stack for addresses in the kernels
text segment or a module text tends to (or at least used to) return a
large quantity of noise.  This makes reading the backtrace nearly
impossible - not only does it contain real function pointers and
return addresses, but also pointers to literal pools and the like.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
