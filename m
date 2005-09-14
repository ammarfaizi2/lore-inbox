Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVINGY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVINGY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVINGY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:24:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57322 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965040AbVINGY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:24:28 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: allinux@gmail.com
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc1] ppc: prevent GCC 4 from generating AltiVec instructions in kernel 
In-reply-to: Your message of "Tue, 13 Sep 2005 23:12:06 MST."
             <cb57165a050913231210fa2b42@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 16:24:12 +1000
Message-ID: <10057.1126679052@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005 23:12:06 -0700, 
Lee Nicks <allinux@gmail.com> wrote:
>Depending on how GCC is built, GCC 4 may generate altivec instructions
>...
>+# No AltiVec instruction when building kernel
>+ifeq ($(call cc-option-yn, -mno-altivec), y)
>+CFLAGS          += -mno-altivec
>+endif

Use the standard format, one line instead of three.

cflags-y += $(call cc-option, -mno-altivec)

