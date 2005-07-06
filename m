Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVGFQUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVGFQUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVGFQSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:18:54 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:1641 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262191AbVGFMDM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:03:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KJKC1CnedZeyz3Q04lJm6wIU8Hv4RSP0raqWm0SuHI2690jLXLUSKHhsTaGbQZrKQsqdsoSlJNN5fDnc/gC0CI4f4HLTqLeRXE8bmf1XjUvBfJhvqash2cSNFnSY8K8nsyKRBw7fvu2at7aWvrGJdpKpdAk6NvQtQC3lqfTmUY8=
Message-ID: <84144f0205070605036e673d5e@mail.gmail.com>
Date: Wed, 6 Jul 2005 15:03:09 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [25/48] Suspend2 2.1.9.8 for 2.6.12: 602-smp.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164422727@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164422727@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/suspend2_common.h 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/suspend2_common.h
> --- 603-suspend2_common-headers.patch-old/kernel/power/suspend2_core/suspend2_common.h  1970-01-01 10:00:00.000000000 +1000
> +++ 603-suspend2_common-headers.patch-new/kernel/power/suspend2_core/suspend2_common.h  2005-07-04 23:14:19.000000000 +1000
> @@ -0,0 +1,49 @@
> +#ifdef CONFIG_PM_DEBUG
> +#define SET_DEBUG_STATE(bit) (test_and_set_bit(bit, &suspend_debug_state))
> +#define CLEAR_DEBUG_STATE(bit) (test_and_clear_bit(bit, &suspend_debug_state))
> +#else
> +#define SET_DEBUG_STATE(bit) (0)
> +#define CLEAR_DEBUG_STATE(bit) (0)
> +#endif
> +
> +#define SET_RESULT_STATE(bit) (test_and_set_bit(bit, &suspend_result))
> +#define CLEAR_RESULT_STATE(bit) (test_and_clear_bit(bit, &suspend_result))
> +
> +#define SUSPEND_ABORT_REQUESTED                1
> +#define SUSPEND_NOSTORAGE_AVAILABLE    2
> +#define SUSPEND_INSUFFICIENT_STORAGE   3
> +#define SUSPEND_FREEZING_FAILED                4
> +#define SUSPEND_UNEXPECTED_ALLOC       5
> +#define SUSPEND_KEPT_IMAGE             6
> +#define SUSPEND_WOULD_EAT_MEMORY       7
> +#define SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY 8
> +#define SUSPEND_ENCRYPTION_SETUP_FAILED        9
> +
> +/* second status register */
> +#define SUSPEND_REBOOT                 1
> +#define SUSPEND_PAUSE                  2
> +#define SUSPEND_SLOW                   3
> +#define SUSPEND_NOPAGESET2             4
> +#define SUSPEND_LOGALL                 5
> +#define SUSPEND_CAN_CANCEL             6
> +#define SUSPEND_KEEP_IMAGE             7
> +#define SUSPEND_FREEZER_TEST           8
> +#define SUSPEND_FREEZER_TEST_SHOWALL   9
> +#define SUSPEND_SINGLESTEP             10
> +#define SUSPEND_PAUSE_NEAR_PAGESET_END 11
> +#define SUSPEND_USE_ACPI_S4            12
> +#define SUSPEND_KEEP_METADATA          13
> +#define SUSPEND_TEST_FILTER_SPEED      14
> +#define SUSPEND_FREEZE_TIMERS          15
> +#define SUSPEND_DISABLE_SYSDEV_SUPPORT 16
> +#define SUSPEND_VGA_POST               17
> +
> +#define TEST_ACTION_STATE(bit) (test_bit(bit, &suspend_action))
> +#define SET_ACTION_STATE(bit) (test_and_set_bit(bit, &suspend_action))
> +#define CLEAR_ACTION_STATE(bit) (test_and_clear_bit(bit, &suspend_action))

Enums, please.
