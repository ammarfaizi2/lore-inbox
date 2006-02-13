Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWBML2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWBML2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWBML2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:28:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6279
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751565AbWBML2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:28:11 -0500
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 12:28:36 +0100
Message-Id: <1139830116.2480.464.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 02:09 +0100, Roman Zippel wrote:
> A const for arguments which are passed by value is completely ignored by
> gcc. It has only an effect on local variables and even here gcc doesn't
> need it either to produce better code.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

NACK - gcc3 produces smaller code with the const - only gcc4 fixed that,
so we want to keep these consts until gcc4 is the only compiler
supported. 		

Also this is neither a regression nor a bug and therefor not required
for 2.6.16.

	tglx


