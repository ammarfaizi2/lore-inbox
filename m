Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRJINNy>; Tue, 9 Oct 2001 09:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277173AbRJINNo>; Tue, 9 Oct 2001 09:13:44 -0400
Received: from web11905.mail.yahoo.com ([216.136.172.189]:35596 "HELO
	web11905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277152AbRJINN0>; Tue, 9 Oct 2001 09:13:26 -0400
Message-ID: <20011009131357.60638.qmail@web11905.mail.yahoo.com>
Date: Tue, 9 Oct 2001 06:13:57 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: No locking is needed ... why?
To: linux-kernel@vger.kernel.org
In-Reply-To: <3BC2F4FA.B29F2546@leoninedev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Could somebody explain me this comment?:
/*
 * Incoming packets are placed on per-cpu queues so
that
 * no locking is needed.
 */

struct softnet_data
{
        int                     throttle;
        int                     cng_level;
        int                     avg_blog;
        struct sk_buff_head     input_pkt_queue;
        struct net_device       *output_queue;
        struct sk_buff          *completion_queue;
} __attribute__((__aligned__(SMP_CACHE_BYTES)));

I didn't understand why packets are placed so and why
locking isn't needed?


__________________________________________________
Do You Yahoo!?
NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
