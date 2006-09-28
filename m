Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWI1J34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWI1J34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWI1J34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:29:56 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:46853 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751797AbWI1J34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:29:56 -0400
Subject: Re: [PATCH 8/8] atmel_serial: Kill at91_register_uart_fns
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <11593762852950-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
	 <11593762853931-git-send-email-hskinnemoen@atmel.com>
	 <11593762851544-git-send-email-hskinnemoen@atmel.com>
	 <11593762851494-git-send-email-hskinnemoen@atmel.com>
	 <1159376285621-git-send-email-hskinnemoen@atmel.com>
	 <11593762852950-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159435315.23157.73.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 11:21:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Haavard,

> at91_register_uart_fns has no users as far as I can see. Let's get
> rid of it.

No.  It is being used.

This interface is used to register board-specific functions that can be
use to control the serial port modem-control lines.

For example, the AT91RM9200 only provides the full modem-control signals
on USART1.  If you need the modem-control signals for any of the other
ports you need to drive some of the GPIO pins manually.  So you need
this hook back into your board-specific file to do that.


Regards,
  Andrew Victor


