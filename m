Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVDZNJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVDZNJC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVDZNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:08:10 -0400
Received: from [81.2.110.250] ([81.2.110.250]:53178 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261505AbVDZNGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:06:04 -0400
Subject: Re: IRQ Disabling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Niessner <Al.Niessner@jpl.nasa.gov>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1114453001.19173.47.camel@morte.jpl.nasa.gov>
References: <1114453001.19173.47.camel@morte.jpl.nasa.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114517101.18330.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 26 Apr 2005 13:05:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-04-25 at 19:16, Al Niessner wrote:
> 1) Write some general handler that resets the IRQ and nothing else and
> install it as the default handler instead of the current one that is
> disabling the IRQ?
> 
> 2) Is there critical information in the report from /var/log/messages
> that I am missing or do not recognize that would allow me to locate and
> identify the rouge hardware that is generating the anomalous interrupt?
> 
> 3) Some other option that I am totally unaware of?

poll ?

The -ac kernel btw has code that handles unidentified IRQs by trying all
the IRQ handlers that have been registered and in "irqpoll" mode polling
them each timer tick to handle lost IRQs. In the case where the problem
is simply bad plumbing it works rather well for rescuing otherwise
unusable laptops

