Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264885AbUEQEDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264885AbUEQEDb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 00:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUEQEDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 00:03:31 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:5056 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264885AbUEQEDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 00:03:30 -0400
To: linux-kernel@vger.kernel.org
Subject: What types are the parameters of memcpy_toio?
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 16 May 2004 21:03:29 -0700
Message-ID: <52lljrwvhq.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 May 2004 04:03:29.0520 (UTC) FILETIME=[E97D9700:01C43BC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a silly question, but what are the types of the parameters
of memcpy_toio and memcpy_fromio?  I was under the impression that IO
addresses are "cookies" and not pointers, and hence should be kept as
unsigned long.

However, <asm-x86_64/io.h> declares them as

void *memcpy_fromio(void*,const void*,unsigned); 
void *memcpy_toio(void*,const void*,unsigned); 

which means my code (which uses unsigned long) gets warnings like

warning: passing arg 1 of `memcpy_toio' makes pointer from integer without a cast

Other architectures seem to expect the IO address to be unsigned long
and explicitly cast it to a pointer.

Thanks,
  Roland
