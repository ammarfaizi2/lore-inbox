Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVCALTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVCALTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVCALTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:19:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49678 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261874AbVCALT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:19:27 -0500
Date: Tue, 1 Mar 2005 11:19:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: updating mtime for char/block devices?
Message-ID: <20050301111922.B29817@flint.arm.linux.org.uk>
Mail-Followup-To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42225CEE.1030104@gmx.net> <1109576878.6298.49.camel@laptopd505.fenrus.org> <4223BB3B.4060309@gmx.net> <20050301093709.A29817@flint.arm.linux.org.uk> <42244EDD.9020204@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42244EDD.9020204@gmx.net>; from c-d.hailfinger.devel.2005@gmx.net on Tue, Mar 01, 2005 at 12:15:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 12:15:41PM +0100, Carl-Daniel Hailfinger wrote:
> Russell King schrieb:
> > tty mtime updates aren't marked dirty, so aren't written back to disk.
> > Intentionally.
> 
> It seems the tty mtime exception doesn't include /dev/ptmx. That's
> probably unintentional. Is there a chance to extend the tty mtime
> exception to all char devices or at least major 4+5?

It does include /dev/ptmx, at least here with 2.6.11-rc2-bk1 and 2.4
kernels.  In fact, it's common to all tty devices since it's handled
by the generic tty code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
