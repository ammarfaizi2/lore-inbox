Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUGHLrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUGHLrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUGHLrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:47:31 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:48811 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264482AbUGHLra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:47:30 -0400
Subject: GCC 3.4 and broken inlining.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 08 Jul 2004 21:46:39 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In response to a user report that suspend2 was broken when compiled with
gcc 3.4, I upgraded my compiler to 3.4.1-0.1mdk. I've found that the
restore_processor_context, defined as follows:

static inline void restore_processor_context(void)

doesn't get inlined. GCC doesn't complain when compiling the file, and
so far as I can see, there's no reason for it not to inline the routine.
But that leaves me confused because some other inlined functions do seem
to get inlined. Can someone tell me what I'm missing?

Regards,

Nigel

