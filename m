Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUAGKlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUAGKlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:41:25 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:47370 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266173AbUAGKlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:41:24 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: block-major aliases (module-init-tools 3.0-pre2)
Date: Wed, 7 Jan 2004 13:40:54 +0300
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071340.54983.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently generate-modprobe.conf is producing block-major-N-* while kernel 
(2.6.0) still calls request_module with block-major-N:

{pts/0}% grep request_module drivers/block/*
drivers/block/genhd.c:  request_module("block-major-%d", MAJOR(dev));

who is correct?

-andrey

