Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTKTA7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 19:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTKTA7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 19:59:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:26561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262767AbTKTA66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 19:58:58 -0500
Date: Wed, 19 Nov 2003 16:59:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Frank Dekervel <kervel@drie.kotnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Message-Id: <20031119165928.70a1d077.akpm@osdl.org>
In-Reply-To: <200311191749.28327.kervel@drie.kotnet.org>
References: <200311191749.28327.kervel@drie.kotnet.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Dekervel <kervel@drie.kotnet.org> wrote:
>
> 2.6.0-test9-mm4 doesn't boot for me ... oops followed by 
> kernel panic - attempted to kill init (2.6.0-test9 works fine). 
> it crashes right after initialising PNP  bios. 

Please make sure that you have CONFIG_KALLSYMS set.

It would help to add `initcall_debug' to the kernel boot command line. 
That way you will find out the address of the final initcall which was
invoked before the kernel crashed.  Please look that up in System.map.

Thanks.
