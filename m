Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbUDBFiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 00:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUDBFiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 00:38:22 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:64524 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263090AbUDBFiV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 00:38:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Chris Shoemaker <chris.shoemaker@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.4] Bad swap file entry, then kernel BUG at mm/shmem.c:475
Date: Fri, 2 Apr 2004 08:38:09 +0300
X-Mailer: KMail [version 1.4]
References: <20040401232734.GB8061@cox.net>
In-Reply-To: <20040401232734.GB8061@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404020838.09566.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 April 2004 02:27, Chris Shoemaker wrote:
> and I haven't found evidence of off-by-bit errors.  However, 2 days
> running memtest86 with all tests, gave no errors.  (BTW, does anyone
> have a suggestion of a more rigorous general hardware stress-test for
> detecting flakiness?)  If my hardware is bad it's pretty intermittent

cpuburn.

Also try to slightly underclock your hardware,
downgrade DMA mode, etc (although it seems you use SCSI...).
Stop using modules you don't absolutely need.

>  Debug: sleeping function called from invalid context at
> include/linux/rwsem.h:43 in_atomic():1, irqs_disabled():0

>  bad: scheduling while atomic!

Some of them are not oopses, just debug.
-- 
vda
