Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVBTDWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVBTDWE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 22:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVBTDWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 22:22:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:64704 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261342AbVBTDWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 22:22:00 -0500
Subject: Re: updated list of unused kernel exports posted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1108847674.6304.158.camel@laptopd505.fenrus.org>
References: <1108847674.6304.158.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 20 Feb 2005 14:20:35 +1100
Message-Id: <1108869635.21611.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 22:14 +0100, Arjan van de Ven wrote:

> +try_acquire_console_sem

This is used by radeonfb and aty128fb at least... though only on ppc for
now... It could be used later in fbdev's for "optisation". Basically, a
trylock semantic on the console semaphore, allows you to try to do
something right away (irq time), but defer if not possible. I use it in
some low level PowerMac PM code.

Ben.


