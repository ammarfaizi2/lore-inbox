Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263288AbVGAJYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbVGAJYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVGAJYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:24:35 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:55762 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263288AbVGAJY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:24:28 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: include/asm-frv/delay.h: bogus ndelay() definition?
Date: Fri, 1 Jul 2005 12:24:09 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507011224.10053.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-frv/delay.h:

static inline void udelay(unsigned long usecs)
 {
        __delay(usecs * __delay_loops_MHz);
 }

#define ndelay(n)      udelay((n) * 5)

This is anything but correct nanosecond delay.
Does anybody know what's going on here?!
--
vda

