Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282810AbRK0FgZ>; Tue, 27 Nov 2001 00:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282811AbRK0FgP>; Tue, 27 Nov 2001 00:36:15 -0500
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:61641 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S282810AbRK0FgJ>;
	Tue, 27 Nov 2001 00:36:09 -0500
Date: Tue, 27 Nov 2001 08:36:02 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: sekhar raja <manamraja@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Doubt in Kernel Timers
Message-Id: <20011127083602.0d19d985.johnpol@2ka.mipt.ru>
In-Reply-To: <20011126125517.27715.qmail@web14504.mail.yahoo.com>
In-Reply-To: <20011126125517.27715.qmail@web14504.mail.yahoo.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 04:55:17 -0800 (PST)
sekhar raja <manamraja@yahoo.com> wrote:

> What do i mean is with out Doing add_timer() can we
> use del_timer(). 

george anzinger is right, you may del_timer() at any time.
If the timer was actually queued, del_timer() returns 0, otherwise, it
returns 1.

But you should use del_timer_sync() to be sure, that your timer function
is not currentky running on other CPU.


> Thanks in Advance
> -Rajasekhar 
---
WBR. //s0mbre
