Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270947AbRH1N0l>; Tue, 28 Aug 2001 09:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270958AbRH1N0b>; Tue, 28 Aug 2001 09:26:31 -0400
Received: from quark.didntduck.org ([216.43.55.190]:38418 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S270947AbRH1N0Z>; Tue, 28 Aug 2001 09:26:25 -0400
Message-ID: <3B8B9C00.4842710D@didntduck.org>
Date: Tue, 28 Aug 2001 09:26:24 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Barth <haba@pdc.kth.se>, linux-kernel@vger.kernel.org
Subject: Re: Size of pointers in sys_call_table?
In-Reply-To: <20010828145304Z.haba@pdc.kth.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Barth wrote:
> 
> Most linux kernel ports export the sys_call_table symbol to be used in
> modules. I have not succeeded how to automatially figure out the size
> of a syscall pointer without inspecting the assembler for the
> architecture in question. Examples are mips and sparc64. Have I
> missed a syscall_t type available or shouldn't there be one?
> 
> Harald.

The layout of the sys_call_table is totally architecture dependant.  The
question to ask here is why do you need to use it?  Modifying it to hook
into syscalls is frowned upon.

--

				Brian Gerst
