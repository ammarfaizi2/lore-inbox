Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUJCXyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUJCXyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUJCXyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:54:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:26307 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268254AbUJCXyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:54:50 -0400
Subject: Re: [PATCH] -mm swsusp: copy_page is harmfull
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200409292014.i8TKEhov023334@hera.kernel.org>
References: <200409292014.i8TKEhov023334@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1096847414.23142.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 09:50:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 10:27, Linux Kernel Mailing List wrote:
> ChangeSet 1.1983.1.3, 2004/09/24 17:27:41-07:00, akpm@osdl.org
> 
> 	[PATCH] -mm swsusp: copy_page is harmfull
> 	
> 	From: Pavel Machek <pavel@ucw.cz>
> 	
> 	This is my fault from long time ago: copy_page can't be used for copying
> 	task struct, therefore we can't use it in swsusp.

Hi !

Just curious, but why ?

It would be useful to have this in platform code, I don't see why I couldn't
use copy_page() on ppc and I suspect it will be more efficient than memcpy
since it has specific optimisations due to the fact that we are known to be
fully aligned and the size of the copy is a constant aligned power of 2.

Ben.


