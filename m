Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVEaWhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVEaWhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEaWhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:37:32 -0400
Received: from smtp07.web.de ([217.72.192.225]:43992 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S261187AbVEaWga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:36:30 -0400
From: Gregor Jasny <gjasny@web.de>
To: linux-kernel@vger.kernel.org
Subject: Cyrix 6x86L does not get identified by Linux 2.6
Date: Wed, 1 Jun 2005 00:36:27 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506010036.27957.gjasny@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on my Cyrix 6x86L (notice the L) I've got the problem that it doesn't get 
identified as a Cyrix processor. Instead it is treated as a common 486.

I think the problem is that the cpuid feature is not enabled after booting. So 
init_cyrix which enables the cpuid feature is never called.

As a bad hack I've set the this_cpu pointer to cyrix in 
common.c:identify_cpu():

this_cpu = cpu_devs[X86_VENDOR_CYRIX];

Who is responsible for x86 CPU detection?

Cheers,
Gregor
