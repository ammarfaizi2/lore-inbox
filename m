Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVADQI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVADQI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVADQI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:08:57 -0500
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:47596 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261713AbVADQHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:07:53 -0500
Date: Tue, 4 Jan 2005 17:10:43 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Lethalman <lethalman@fyrebird.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let me know EIP address
Message-Id: <20050104171043.21c7c4ef@tux.homenet>
In-Reply-To: <41DAB3AA.4010207@fyrebird.net>
References: <41DAB3AA.4010207@fyrebird.net>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2005 16:18:02 +0100
Lethalman <lethalman@fyrebird.net> wrote:

> I'm trying to get the EIP value from a simple program in C but i don't
> how to do it. I need it to know the current address position on the
> code segment.
> 
> main() {
>    long *eip;
>    asm("mov %%eip,%0" : "=g"(eip));
>    printf("%p\n", eip);
> }
> 
> Unfortunately EIP is not that kind of register :P
> Does anyone know how to get EIP?


IA-32 Intel® Architecture
    Software Developer's
                    Manual
                    Volume 1:
            Basic Architecture


3.5. INSTRUCTION POINTER

[...]

The EIP register cannot be accessed directly by software; it is
controlled implicitly by control- transfer instructions (such as JMP,
Jcc, CALL, and RET), interrupts, and exceptions. The only way to read
the EIP register is to execute a CALL instruction and then read the
value of the return instruction pointer from the procedure stack. The
EIP register can be loaded indirectly by modifying the value of a return
instruction pointer on the procedure stack and executing a return
instruction (RET or IRET). See Section 6.2.4.2., "Return Instruction
Pointer".

[...]

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.10-cko2)
