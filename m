Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267149AbTGGRmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTGGRmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:42:49 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:58809 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S267149AbTGGRmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:42:37 -0400
Message-Id: <5.1.0.14.2.20030707105151.062fa550@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Jul 2003 10:56:48 -0700
To: ilmari@ilmari.org (Dagfinn Ilmari =?iso-8859-1?Q?Manns=E5ker?= ),
       bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: rfcomm oops in 2.5.74
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d8jfzlnym1h.fsf@wirth.ping.uio.no>
References: <d8jznjvzr07.fsf@wirth.ping.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:04 PM 7/3/2003, Dagfinn Ilmari Mannsåker wrote:
>ilmari@ilmari.org (Dagfinn Ilmari MannsÃ¥ker) writes:
>
>> Calling socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM) on 2.5.74
>> segfaults and gives the below oops. module.h:297 is
>> BUG_ON(module_refcount(module) == 0) in __module_get(), which is called
>> from rfcomm_sock_alloc() via sk_set_owner().
>
>It turns out that net/bluetooth/rfcomm/sock.c (and
>net/bluetooth/hci_sock.c) had been left out when net_proto_family gained
>an owner field, here's a patch that fixes them both. Now I can transfer
>pictures from my phone over OBEX Object Push again :)
HCI socket doesn't need an owner field. But RFCOMM does I'll fix that.

Thanks for the patch
Max

