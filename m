Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVAKFTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVAKFTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 00:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVAKFTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 00:19:12 -0500
Received: from one.firstfloor.org ([213.235.205.2]:28352 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262349AbVAKFTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 00:19:09 -0500
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: panic when munmap()ping the stack
References: <1105401719.4153.2.camel@localhost>
From: Andi Kleen <ak@muc.de>
Date: Tue, 11 Jan 2005 06:19:08 +0100
In-Reply-To: <1105401719.4153.2.camel@localhost> (Jeremy Fitzhardinge's
 message of "Mon, 10 Jan 2005 16:01:58 -0800")
Message-ID: <m1ekgsczlf.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> This program causes an instant panic for me:
>
>         #include <sys/mman.h>
>         
>         int main(int argc, char **argv)
>         {
>         	munmap((char *)(((unsigned long)&argc) & ~4095), 4096*2);
>         
>         	return 0;
>         }

I think Linus already fixed that. Can you try the latest -BK?
It's a fallout of the new clear_page_tables()

-Andi
