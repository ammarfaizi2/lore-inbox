Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285213AbRLRVpN>; Tue, 18 Dec 2001 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285206AbRLRVnz>; Tue, 18 Dec 2001 16:43:55 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:49925 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285226AbRLRVms>; Tue, 18 Dec 2001 16:42:48 -0500
Date: Tue, 18 Dec 2001 21:42:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org, 125612@bugs.debian.org
Subject: Re: APM driver patch summary
Message-ID: <20011218214235.I13126@flint.arm.linux.org.uk>
In-Reply-To: <1008710648.21102.1.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008710648.21102.1.camel@thanatos>; from jdthood@mail.com on Tue, Dec 18, 2001 at 04:24:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 04:24:05PM -0500, Thomas Hood wrote:
> Move "sti()" up a bit inside suspend() function.  (Should be harmless.)

Doesn't guarantee that you'll keep interrupts disabled.

suspend() calls pm_send_all() which calls down() which might call
schedule(), which I think you'll find will re-enable interrupts.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

