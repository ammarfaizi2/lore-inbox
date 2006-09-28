Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWI1Imm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWI1Imm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWI1Imm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:42:42 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:40453 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751788AbWI1Iml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:42:41 -0400
Subject: Re: [PATCH 3/8] at91_serial -> atmel_serial: Kconfig symbols
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <11593762851735-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159432488.23157.25.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 10:34:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Haavard,

> Rename the following Kconfig symbols:
>   * CONFIG_SERIAL_AT91 -> CONFIG_SERIAL_ATMEL
>   * CONFIG_SERIAL_AT91_CONSOLE -> CONFIG_SERIAL_ATMEL_CONSOLE
>   * CONFIG_SERIAL_AT91_TTYAT -> CONFIG_SERIAL_ATMEL_TTYAT


> -config SERIAL_AT91
> -	bool "AT91RM9200 / AT91SAM9261 serial port support"
> +config SERIAL_ATMEL
> +	bool "AT91 / AT32 on-chip serial port support"
>  	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261)
>  	select SERIAL_CORE
>  	help
>  	  This enables the driver for the on-chip UARTs of the Atmel
>  	  AT91RM9200 and AT91SAM926 processor.

Shouldn't this dependency be:
   depends on (ARM && ARCH_AT91) || AVR32

(The "ARCH_AT91RM9200 || ARCH_AT91SAM9261" can be replaced with
ARCH_AT91 since the driver should usable on the RM9200, SAM9261 and
SAM9260)

The help text should probably also be updated for these 3 options so
that it mentions the AVR32.


Regards,
  Andrew Victor



