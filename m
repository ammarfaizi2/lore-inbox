Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbSJIPBd>; Wed, 9 Oct 2002 11:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261796AbSJIPBd>; Wed, 9 Oct 2002 11:01:33 -0400
Received: from quark.didntduck.org ([216.43.55.190]:65292 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S261795AbSJIPBc>; Wed, 9 Oct 2002 11:01:32 -0400
Message-ID: <3DA44603.2000708@didntduck.org>
Date: Wed, 09 Oct 2002 11:06:43 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "J.A. Magallon" <jamagallon@able.es>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
References: <Pine.LNX.3.95.1021009103521.3016B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> I would like to be able to write to that variable and have it seen
> by other tasks, since shared memory is shared memory. It's a shame
> to mmap a shared library upon startup and then have to mmap some
> additional shared memory for some inter-process communication.

There are only two ways to share memory between processes:
- SYSV shared memory
- using clone() to share the VM.

Shared libraries != shared memory.  Each mapping of a shared library is 
copy-on-write.  The purpose of shared libraries is to save memory, not 
for IPC.

--
				Brian Gerst


