Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVHJOdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVHJOdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVHJOdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:33:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57064 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965120AbVHJOdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:33:31 -0400
Subject: Re: [PATCH] Fix ide-disk.c oops caused by hwif == NULL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, kiran@scalex86.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0508100604020.12126@schroedinger.engr.sgi.com>
References: <200508100459.j7A4xTn7016128@hera.kernel.org>
	 <Pine.LNX.4.62.0508101310300.18940@numbat.sonytel.be>
	 <Pine.LNX.4.62.0508100604020.12126@schroedinger.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Aug 2005 15:59:57 +0100
Message-Id: <1123685998.28913.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-10 at 06:07 -0700, Christoph Lameter wrote:
> Correct. So we need to indeed go back to a version that does check for 
> NULL that I initially proposed.

No, you need to fix the caller. "hwif_to_node(NULL)" is a nonsense
operation rather like strlen(NULL). The caller need to be fixed.

