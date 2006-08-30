Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWH3QCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWH3QCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWH3QCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:02:20 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:61868 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751098AbWH3QCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:02:19 -0400
Date: Wed, 30 Aug 2006 12:02:14 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, ak@muc.de, vojtech@suse.cz
Subject: arch/x86_64/kernel/traps.c:show_trace should use __kernel_text_address
Message-ID: <20060830160214.GA5557@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:58:28 up 7 days, 13:07,  5 users,  load average: 0.99, 0.38, 0.18
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed arch/x86_64/kernel/traps.c:show_trace uses kernel_text_address to
verify that an address can potentially belong to kernel code. However, this
version takes a spinlock and should not be called from oops. I think
__kernel_text_address would be more appropriate there.

Mathieu Desnoyers


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
