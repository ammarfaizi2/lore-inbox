Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282379AbRLRM7Q>; Tue, 18 Dec 2001 07:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281921AbRLRM7G>; Tue, 18 Dec 2001 07:59:06 -0500
Received: from imo-r03.mx.aol.com ([152.163.225.99]:10691 "EHLO
	imo-r03.mx.aol.com") by vger.kernel.org with ESMTP
	id <S281916AbRLRM6v>; Tue, 18 Dec 2001 07:58:51 -0500
From: Telford002@aol.com
Message-ID: <e5.10e6703a.29509786@aol.com>
Date: Tue, 18 Dec 2001 07:58:46 EST
Subject: TTY Driver Open and Close Logic
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 5.0 for Windows sub 139
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been working on various serial drivers and I notice that physical
driver close routine is called in all cases even if the physical driver
open routine fails.  That suggests to me that a lot of the MOD_DEC/INC_COUNT
logic in serial.c and other physical serial drivers is incorrect.  As
serial.c seems usually to be compiled into the kernel the issue
is not so important, but a lot of the other logic associated with
open counts also seems incorrect.  Is this observation correct?

Joachim Martillo
