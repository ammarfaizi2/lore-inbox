Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265636AbUEZP4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUEZP4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbUEZP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:56:47 -0400
Received: from nat-ph3-wh.rz.uni-karlsruhe.de ([129.13.73.33]:1664 "EHLO
	au.hadiko.de") by vger.kernel.org with ESMTP id S265632AbUEZP4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 11:56:37 -0400
From: Jens =?iso-8859-1?q?K=FCbler?= <cleanerx@au.hadiko.de>
To: linux-kernel@vger.kernel.org
Subject: nforce2 keeps crashing with 2.4.27pre3
Date: Wed, 26 May 2004 17:56:35 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405261756.35333.cleanerx@au.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have grabbed the latest pre of the kernel and compiled everything. At bootup 
the nforce2 fixup message appears but as soon as I cause heavy network 
traffic the system still locks up. 
I'm using a rtl8169 1Gbit network card which reads data from a 1Gbit connected 
raid10 so transfer rates can get pretty high (some tests gave me about 70MB/s 
reading)

The system runs fine with the apic tack patch that i use since december 
(kernel 2.4.23) except for my new gigabit network card.
I'm importing different network shares via nfs and the gigabit seems to have 
problems with this patch. When traffic rises the kernel considers that the 
nfs server is not responding and waits for it to come back. It does after 
some time and then this cycle starts again and again. Transfer rates drop due 
to this to less than 1Mb/s.

When I installed 2.4.27pre3 i had none of these nfs timeouts but the system 
halt. The whole home directory is imported via nfs and it seemed for me much 
more responsive than with the apic tack patched kernel.

I will be greatful for any suggestions.

Btw: I'm not subscribed so please send cc to me ;-)

Jens

