Return-Path: <linux-kernel-owner+w=401wt.eu-S1751052AbWLNRrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWLNRrK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWLNRrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:47:10 -0500
Received: from www.osadl.org ([213.239.205.134]:44580 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751052AbWLNRrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:47:08 -0500
From: =?utf-8?q?Hans-J=C3=BCrgen_Koch?= <hjk@linutronix.de>
Organization: Linutronix
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Thu, 14 Dec 2006 18:47:02 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061213195226.GA6736@kroah.com> <200612141056.03538.hjk@linutronix.de> <1166117658.28664.105.camel@tara.firmix.at>
In-Reply-To: <1166117658.28664.105.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612141847.03592.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 18:34 schrieb Bernd Petrovitsch:
> On Thu, 2006-12-14 at 10:56 +0100, Hans-Jürgen Koch wrote:
> [....]
> > A small German manufacturer produces high-end AD converter cards. He sells
> > 100 pieces per year, only in Germany and only with Windows drivers. He would
> > now like to make his cards work with Linux. He has two driver programmers
> > with little experience in writing Linux kernel drivers. What do you tell him?
> > Write a large kernel module from scratch? Completely rewrite his code 
> > because it uses floating point arithmetics?
> 
> Find a Linux kernel guru/company and pay him/them for
> -) an evaluation if it is "better" (for whatever better means) to port
> the driver
>      or write it from scratch and
> -) do the better thing.

Good idea - whatever "porting" means. There are lots of Windows drivers out there
that are also partly user space using that Kithara stuff. They have most of their
driver in a dll. So that is similar to what we want with UIO - except that we 
handle interrupts in a clean way, they don't.
If you need to port such a driver, simply writing a kernel module and a user space
library would change so much of the concept that you can start rewriting it from
scratch. And you'll have a large kernel module to maintain. OK, the guru/company
can earn money with it, at least as long as the customer doesn't realize it is
not the best solution for him.

Hans

