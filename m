Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUCKPTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUCKPTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:19:30 -0500
Received: from relay-6v.club-internet.fr ([194.158.96.111]:1181 "EHLO
	relay-6v.club-internet.fr") by vger.kernel.org with ESMTP
	id S261388AbUCKPTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:19:22 -0500
From: pinotj@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: [i386] 2.6.4 + cdrtools-2.01a27 REPORT
Date: Thu, 11 Mar 2004 16:19:21 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet5.1079018361.4673.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just wanted to report that cdrtools-2.01a27 seems to works well
with the new 2.6.4 kernel via ide-cd but there is a tricky thing
to know in order to compile the package, I had to use:

make COPTX='-Du8=UInt8_t -D__attribute_const__=__const__'

..to succeed compiling the libscg and so the binaries.
The first macro apply to linux/include/scsi/scsi.h and the
second to linux/include/asm-i386/byteorder.h

The burning process was OK for me but I would like to know if
 there is possibly some bad side effects and why __const__ was changed for __attribute_const__ (yeah, I don't know the difference and I'm curious ;-)

I post this because I think it will maybe help some people that want to switch to a 2.6 and burn some CD quickly.

Regards,

Jerome Pinot

