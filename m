Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSGAVua>; Mon, 1 Jul 2002 17:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSGAVu3>; Mon, 1 Jul 2002 17:50:29 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:48913 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316535AbSGAVu3>;
	Mon, 1 Jul 2002 17:50:29 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207012152.g61LqjX387143@saturn.cs.uml.edu>
Subject: Re: Diff b/w 32bit & 64-bit
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 1 Jul 2002 17:52:45 -0400 (EDT)
Cc: MohamedG@ggn.hcltech.com (Mohamed Ghouse Gurgaon),
       linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <yw1xpty71bea.fsf@gladiusit.e.kth.se> from "=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=" at Jul 01, 2002 09:44:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?q?M=E5ns_Rullg=E5rd?= writes:

> For Alpha: sizeof(int) == 4, sizeof(long) == 8, sizeof(void *) == 8
> For intel: sizeof(int) == 4, sizeof(long) == 4, sizeof(void *) == 8

That second line is _only_ correct for Win64.
The Linux way:

char is 8 bits
char may be signed or unsigned by default
short is 16 bits
int is 32 bits
long is the name number of bits as a pointer
long is either 32 bits or 64 bits
long long is 64 bits
don't cast from "foo *" to "bar *" if sizeof(foo)<sizeof(bar)
in a struct, put big items first to avoid padding
don't use "long" in a struct that goes to disk or over the network
with few exceptions, floating-point math in the kernel is prohibited
don't assume that all physical memory is continuously mapped
don't assume that you can DMA to any address you like
