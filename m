Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTINIT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbTINIT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:19:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1549 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262345AbTINITZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:19:25 -0400
Date: Sun, 14 Sep 2003 09:19:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. modem cards
Message-ID: <20030914091922.C20889@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <1b7401c37a73$87b0e250$2dee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1b7401c37a73$87b0e250$2dee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Sep 14, 2003 at 12:51:36PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 12:51:36PM +0900, Norman Diamond wrote:
> In file 8250_cs.c:
> Line 61, identifies itself as "serial_cs.c" instead of "8250_cs.c".
> Line 119 identifies itself as "serial_cs" instead of "8250_cs".
> My partial understanding of Linux PCMCIA operations yields a guess that line
> 119 is part of the cause for failure during execution, whereas line 61 only
> potentially confuses future maintainers.

Its going to get renamed back to serial_cs shortly.

> Later in the same source file, calls to register_serial() and
> unregister_serial() compile but fail during execution.  Of course in order
> to make it execute in the first place I have to manually modprobe 8250_cs,
> because of the reason mentioned above.  /var/log/messages gets reports that
> those symbols are unknown.

I have no idea how you managed that.  The configuration subsystem does
not allow you to build 8250_cs.c as a module without building 8250.c in
some manner, and 8250.c provides those symbols.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
