Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSILTV0>; Thu, 12 Sep 2002 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSILTV0>; Thu, 12 Sep 2002 15:21:26 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:25095 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317017AbSILTVZ>;
	Thu, 12 Sep 2002 15:21:25 -0400
Message-ID: <3D80EB86.52321F1F@tv-sign.ru>
Date: Thu, 12 Sep 2002 23:31:18 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: Linux 2.5.34
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Could anybody explain this change in force_sig_info() in 2.5.34:

-	return send_sig_info(sig, info, t);
+	return send_sig_info(sig, (void *)1, t);

Looks wrong to me...

Also, task_struct->shared_unblocked seems to be unused.

Oleg.
