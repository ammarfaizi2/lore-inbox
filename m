Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424577AbWKKM2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424577AbWKKM2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424578AbWKKM2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:28:53 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:19 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1424577AbWKKM2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:28:52 -0500
Date: Sat, 11 Nov 2006 12:28:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: where can I select INPUT?
Message-ID: <20061111122841.GB24112@flint.arm.linux.org.uk>
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <200611111325.02749.arvidjaar@mail.ru> <20061111112528.GY4729@stusta.de> <200611111518.42238.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611111518.42238.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 03:18:41PM +0300, Andrey Borzenkov wrote:
> On Saturday 11 November 2006 14:25, Adrian Bunk wrote:
> > The rationale is that it usually doesn't make sense for users to disable
> > INPUT, and allowing it tends to cause some confusion.
> 
> I do not want to disable it. I want to make it module (OK it has the same 
> rationale - if you need it anyway why you do want to make it module etc). 
> This should be possible according to help text. It does not work. Direct 
> editing of .config silently reverts it back to y instead of m.

Welcome to the wonderful world of the 'select' kconfig statement.

config VT
        bool "Virtual terminal" if EMBEDDED
        select INPUT
        default y if !VIOCONS

This means if VT is selected, INPUT has to be 'y'.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
