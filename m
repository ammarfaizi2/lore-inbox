Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263970AbUD0KEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbUD0KEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 06:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUD0KEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 06:04:05 -0400
Received: from mail1.webmessenger.it ([193.70.193.50]:51413 "EHLO
	mail1c.webmessenger.it") by vger.kernel.org with ESMTP
	id S263970AbUD0KED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 06:04:03 -0400
From: "Martin Angler" <martin.angler@email.it>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel space vs. user space for RS-485
Date: Tue, 27 Apr 2004 12:04:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Thread-Index: AcQsPvkFLo+6wc9pR9GvLJBO68i/AA==
Message-Id: <S263970AbUD0KED/20040427100403Z+208@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have to develop a pseudo-device driver that gets data from a RS485
interface, frames it and gives the framed data to libpcap. This whole thing
is a university project. Now I know, that writing a kernel module I can't be
using the standard C library for invocations of read() or ioctl() methods in
order to get the data from the RS485 interface. 

So my plan would be writing a driver xxx which has its file operations
xxx_read, xxx_open and xxx_release. xxx_read should call then some kind of
read method in order to get the data from the RS485. Are there any exported
symbols from the RS485 driver? Or do I have to write the whole driver in
user space in order to access the RS485 interface?

Thanks in advance,

Martin Angler



