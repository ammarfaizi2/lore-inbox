Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTGCOuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTGCOuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:50:00 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:10512 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263738AbTGCOt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:49:58 -0400
Message-ID: <3F04458C.4070502@prim-time.fr>
Date: Thu, 03 Jul 2003 17:02:36 +0200
From: Aurelien Minet <a.minet@prim-time.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030521 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Dagfinn_Ilmari_Manns=E5ker?= <ilmari@ilmari.org>
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] rfcomm oops in 2.5.74
References: <d8jznjvzr07.fsf@wirth.ping.uio.no>
In-Reply-To: <d8jznjvzr07.fsf@wirth.ping.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dagfinn


> Calling socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM) on 2.5.74
> segfaults and gives the below oops. module.h:297 is
> BUG_ON(module_refcount(module) == 0) in __module_get(), which is called
> from rfcomm_sock_alloc() via sk_set_owner().

I don't know for 2.5.xx  but for 2.4.xx in order to use RFCOMM protocol 
you must use a SOCK_STREAM and not SOCK_RAW socket type.
(SOCK_RAW is for HCI , SOCK_SEQPACKET & SOCK_DGRAM for L2cap)
I think it must return an error instead of making a segfault, in this 
way it is a bug.


Regards

Aurelien

