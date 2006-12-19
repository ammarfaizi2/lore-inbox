Return-Path: <linux-kernel-owner+w=401wt.eu-S932947AbWLSVV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbWLSVV4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933002AbWLSVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:21:55 -0500
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:33824 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932947AbWLSVVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:21:55 -0500
X-Greylist: delayed 1341 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 16:21:54 EST
Subject: Three if-clauses of constant logic value; char drivers for kernel
	2.4.33.3
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 19 Dec 2006 21:59:37 +0100
Message-Id: <1166561978.4133.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-Scan-Result: No virus found in message 1Gwm4M-0000tB-7H.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1Gwm4M-0000tB-7H 3c486e8f3cf7827ad31cbc316365317c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, all masters of kernel code,

I just discovered that the kernel code for 2.4.33.3 contains three
if-statements that never can change their values, whence they should
be repaired or eliminated. In source directory linux/drivers/char the
files vt.c and keyboard.c produce these warning upon compilation:

    vt.c:166: varning: comparison is always false due to limited range  
              of data type
    vt.c:289: varning: comparison is always false due to limited range
              of data type
    keyboard.c:640: varning: comparison is always true due to limited
                    range of data type

I did the compilation with gcc 3.3.5 on Debian Sarge. This behaviour
appeared first for kernel 2.2.19, since I wanted to revive the old
minirtl edition, but to my surprise the same warnings appear also
with the brand new kernel 2.4.33.3.

Best regards
             Mats Erik Andersson, PhD
             ynglingatal@yahoo.se
             mats.andersson64@comhem.se

