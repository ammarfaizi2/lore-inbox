Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267296AbTGLCQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 22:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTGLCQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 22:16:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267296AbTGLCQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 22:16:46 -0400
Date: Fri, 11 Jul 2003 19:31:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow LBD on architectures that support it
Message-Id: <20030711193135.4edd7557.akpm@osdl.org>
In-Reply-To: <200307120224.h6C2ONNR016854@sullivan.realtime.net>
References: <200307120224.h6C2ONNR016854@sullivan.realtime.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller <miltonm@bga.com> wrote:
>
>  config LBD
>   	bool "Support for Large Block Devices"
>  -	depends on X86
>  +	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH

yup, the idea was that architecture maintainers could come in and turn this
on once they had verified that it actually works OK.

However I don't have a problem with just doing the above and then listening
for distant bangs.
