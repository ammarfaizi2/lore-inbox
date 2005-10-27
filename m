Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVJ0HOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVJ0HOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVJ0HOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:14:53 -0400
Received: from beret.waw.pdi.net ([213.241.71.70]:60690 "EHLO beret.srv.pl")
	by vger.kernel.org with ESMTP id S964978AbVJ0HOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:14:52 -0400
Subject: dumb muliport serial cards not supported in 2.6.13.4 ???
From: Jarek <jarek@macro-system.com.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Macro System
Date: Thu, 27 Oct 2005 09:14:18 +0200
Message-Id: <1130397258.13942.14.camel@jarek.macro>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

	I've PCM 3643, 8 port dumb multiport serial card from Advantech.
	This card works nice with 2.6.12 but with 2.6.13.4 I can see only two
ports!
	This is dumb 8250 (exactly: 16550A) multiport board. In 2.6.12 I've the
following settings:

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_MULTIPORT=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y

I've tried to setup same in 2.6.13.4, but it claims:
.config:761: trying to assign nonexistent symbol SERIAL_8250_MULTIPORT

I suspect that this is the problematic setting but there is nothing
about this in any Changelog.

What should I do ?

Jarek.

