Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292678AbSCDSoH>; Mon, 4 Mar 2002 13:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292674AbSCDSn7>; Mon, 4 Mar 2002 13:43:59 -0500
Received: from zero.tech9.net ([209.61.188.187]:16911 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292678AbSCDSnw>;
	Mon, 4 Mar 2002 13:43:52 -0500
Subject: Re: FW: BUG in spinlock.h:133
From: Robert Love <rml@tech9.net>
To: Alexander Sandler <ASandler@store-age.com>
Cc: Linux Kernel "Mailing List (E-mail)" 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <DCC3761A6EC31643A3BAF8BB584B26CC0AAE8A@exchange.store-age.com>
In-Reply-To: <DCC3761A6EC31643A3BAF8BB584B26CC0AAE8A@exchange.store-age.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 13:43:51 -0500
Message-Id: <1015267432.15479.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 06:50, Alexander Sandler wrote:

> I am getting a BUG in include/asm-i386/spinlock.h:133 when I am doing some
> I/O with driver I am working on. Does anyone has any idea what it can be?
> The system is Linux RedHat 7.1 on dual CPU machine running kernel 2.4.16.

That BUG means lock->magic was not set properly, which is a debug-only
parameter to make sure the lock was properly initialized.

Thus, either you are not properly initializing your spin_locks or there
is a memory corruption problem.

The EIP at the time of the BUG should of been reported - what was it? 
Find it in your System.map to see where the problem is ...

	Robert Love

