Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWI1Jif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWI1Jif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWI1Jif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:38:35 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:52472 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751752AbWI1Jie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:38:34 -0400
Date: Thu, 28 Sep 2006 11:38:57 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] atmel_serial: Kill at91_register_uart_fns
Message-ID: <20060928113857.0e3e7c48@cad-250-152.norway.atmel.com>
In-Reply-To: <1159435315.23157.73.camel@fuzzie.sanpeople.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	<115937628584-git-send-email-hskinnemoen@atmel.com>
	<11593762852168-git-send-email-hskinnemoen@atmel.com>
	<11593762851735-git-send-email-hskinnemoen@atmel.com>
	<11593762853931-git-send-email-hskinnemoen@atmel.com>
	<11593762851544-git-send-email-hskinnemoen@atmel.com>
	<11593762851494-git-send-email-hskinnemoen@atmel.com>
	<1159376285621-git-send-email-hskinnemoen@atmel.com>
	<11593762852950-git-send-email-hskinnemoen@atmel.com>
	<1159435315.23157.73.camel@fuzzie.sanpeople.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Sep 2006 11:21:55 +0200
Andrew Victor <andrew@sanpeople.com> wrote:

> hi Haavard,
> 
> > at91_register_uart_fns has no users as far as I can see. Let's get
> > rid of it.
> 
> No.  It is being used.
> 
> This interface is used to register board-specific functions that can
> be use to control the serial port modem-control lines.
> 
> For example, the AT91RM9200 only provides the full modem-control
> signals on USART1.  If you need the modem-control signals for any of
> the other ports you need to drive some of the GPIO pins manually.  So
> you need this hook back into your board-specific file to do that.

Ok, I sort of suspected that. But I can't see any users in the kernel
tree, so perhaps we should leave the name of the function alone too?
(i.e. just drop the patch)

Haavard
