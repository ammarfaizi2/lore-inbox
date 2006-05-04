Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWEDHPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWEDHPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWEDHPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:15:44 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:42454 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1751418AbWEDHPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:15:43 -0400
Message-ID: <4459AA1B.9020207@tremplin-utc.net>
Date: Thu, 04 May 2006 09:15:39 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060422)
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: limits / PIPE_BUF?
References: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05/04/2006 07:55 AM, Vadim Lobanov wrote/a écrit:
> Hi,
Hi!

:
> 
> A snippet from include/linux/limits.h:
> #define PIPE_BUF        4096    /* # bytes in atomic write to a pipe */
> 
> PIPE_BUF is a bit of an oddity. It is defined there, then redefined in
> the arm header files, even though those header files are never included
> anywhere.
Actually, here, on a 2.6.16 source code, PIPE_BUF is used in 
arch/sparc/kernel/sys_sunos.c, arch/sparc64/kernel/sys_sunos32.c, and 
arch/sparc64/solaris/fs.c . It seems it's some kind of compatibility 
value with Sun's OS...


> Also, PIPE_BUF is never referenced by name in any of the Linux
> code. And yet, it is still being mentioned in some Big And Scary
> Warnings (tm): fs/autofs4/waitq.c or include/linux/pipe_fs_i.h, for
> example.
Maybe they wanted to say PIPE_BUFFERS ? (just wild guess)

c u,
Eric
