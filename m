Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264599AbTLCQDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264603AbTLCQDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:03:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:54956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264599AbTLCQDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:03:52 -0500
Date: Wed, 3 Dec 2003 08:03:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAA@stca204a.bus.sc.rolm.com>
Message-ID: <Pine.LNX.4.58.0312030802420.5258@home.osdl.org>
References: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAA@stca204a.bus.sc.rolm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Bloch, Jack wrote:
>
> I try to open a non-existan device driver node file. The Kernel returns a
> value of -1 (expected). However, when I read the value of errno it contains
> a value of 29. A call to the perror functrion does print out the correct
> error message (a value of 2). Why does this happen?

Because you forgot a "#include <errno.h>"? Or you have something else
wrong in your program that makes "errno" mean the wrong thing?

		Linus
