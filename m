Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUHRXsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUHRXsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267621AbUHRXsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:48:21 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:26776 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267632AbUHRXoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:44:54 -0400
Date: Thu, 19 Aug 2004 08:45:00 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC]Kexec based crash dumping
Cc: oda@valinux.co.jp
Message-Id: <20040819083333.76F4.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

It is interesting.

We(*) also make crash dump acording to similer concept.
    (*) NTT Data Corporation & VA Linux Systems Japan K.K.

Our main idea is the following.

- prepare a kernel which does only dump real memory to block
  device. ("dump mini kernel")
- pre-allocate the memory (4MB is enough) used by the dump mini
  kernel and pre-load the dump mini kernel.
- when crash occur exec the dump mini kernel.
- the dump mini kernel stands in and only uses pre-allocated
  area.

We made mkexec(mini kernel exec) based on kexec code but 
simplify a lot. Mkexec can co-exist kexec and can be kernel
module. We made also "dump mini kernel". 
(now i386 only)

We will open our code shortly. (maybe I think)
I think there are many items to be able to cooperate.

Thank you.
-- 
Itsuro ODA <oda@valinux.co.jp>

