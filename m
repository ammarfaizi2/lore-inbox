Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUHOWI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUHOWI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUHOWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:08:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:53431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267176AbUHOWI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:08:26 -0400
Date: Sun, 15 Aug 2004 15:06:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-Id: <20040815150635.5ac4f5df.akpm@osdl.org>
In-Reply-To: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> The patch below makes UML build in the face of the ldchk addition to 2.6.8.

Confused.  Your vmlinux.lds.S doesn't look anything like mine:


#include <asm-generic/vmlinux.lds.h>
	
OUTPUT_FORMAT(ELF_FORMAT)
OUTPUT_ARCH(ELF_ARCH)
ENTRY(_start)
jiffies = jiffies_64;

SECTIONS
{
#include "asm/common.lds.S"
}

