Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269452AbUICJOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269452AbUICJOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269432AbUICJNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:13:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:54199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269464AbUICJG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:06:27 -0400
Date: Fri, 3 Sep 2004 02:04:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.9-rc1-mm2 compilation fixes
Message-Id: <20040903020435.0027958a.akpm@osdl.org>
In-Reply-To: <200409030857.25295.bero@arklinux.org>
References: <200409030857.25295.bero@arklinux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> make modules_install doesn't work if the ALSA korg1212 sound module is built - 
> "grep -h .ko" will find /korg1212.o (. is a regexp character...), and 
> therefore try to install the nonexistant korg1212.ko.
> It should be grep -h '\.ko'

Yup.  This should be fixed in -mm3, thanks.

> kernel/wait.c fails to compile with gcc 3.4 due to discrepancies between the 
> prototype and implementations of __wait_on_bit() and __wait_on_bit_lock()

This also.
