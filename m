Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWIIQbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWIIQbI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 12:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWIIQbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 12:31:08 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:4429 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964800AbWIIQbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 12:31:05 -0400
Subject: Re: [PATCH -mm] scsi: compile error on module_refcount
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
In-Reply-To: <20060909162635.746696000@mvista.com>
References: <20060909162635.746696000@mvista.com>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 09:31:03 -0700
Message-Id: <1157819464.8721.24.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 09:26 -0700, dwalker@mvista.com wrote:
> Fixes the following compile error,
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x8e1f9): In function `scsi_device_put':
> drivers/scsi/scsi.c:887: undefined reference to `module_refcount'
> make: *** [.tmp_vmlinux1] Error 1
> 
> There are only two users of module_refcount() outside of kernel/module.c
> and the other one uses ifdef's similar to this.
> 

of course,

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

