Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTDXI6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTDXI6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:58:34 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:61568 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261916AbTDXI6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:58:34 -0400
Date: Thu, 24 Apr 2003 05:06:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [ANNOUNCE] desc.c -- dump the i386 descriptor tables
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304240509_MC3-1-35CF-A2DD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli wrote:


> Spiffy; this should help debug various things.


  I forgot to mention: try comparing 2.2, 2.4 and 2.5.

  Also, this is what I've been using to look at interrupt entry
point alignment.  On 2.4 for sure, and probably on 2.5 you have
a 1-in-8 chance of getting a pathologically badly aligned timer
handler on 32-byte cacheline machines every time you compile
(IRQ 0 entry address & 0x1f == 0x1c.)  OTOH the pagefault handler
has come up 8-byte aligned every time but I didn't look at the
source to see if it's coded that way.

------
 Chuck
