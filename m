Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbTGDI3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbTGDI3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:29:21 -0400
Received: from web21408.mail.yahoo.com ([216.136.232.78]:39029 "HELO
	web21408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265870AbTGDI3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:29:21 -0400
Message-ID: <20030704084348.70534.qmail@web21408.mail.yahoo.com>
Date: Fri, 4 Jul 2003 10:43:48 +0200 (CEST)
From: "=?iso-8859-1?q?J.=20Angel=20S.=20Caso?=" <altomaltes@yahoo.es>
Subject: A little bugfix for linux 2.5.71
To: linux-kernel@vger.kernel.org
Cc: jasanchez@polar.es
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a little problem that causes a broken
compilation. The problem is that "net/core/flow.c"
does not include "linux/cpu.h", and thereby does not
puts the "register_cpu_notifier" dummy patch in
himself in no SMP compilations.

If you include linux/cpu.h before linux/smp.h the
compilation in no SMP kernels is OK.

regards.

José Angel Sánchez Caso

___________________________________________________
Yahoo! Messenger - Nueva versión GRATIS
Super Webcam, voz, caritas animadas, y más...
http://messenger.yahoo.es
