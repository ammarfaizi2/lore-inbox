Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282847AbRK0H5p>; Tue, 27 Nov 2001 02:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282849AbRK0H5i>; Tue, 27 Nov 2001 02:57:38 -0500
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:33484 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S282846AbRK0H5S>;
	Tue, 27 Nov 2001 02:57:18 -0500
Date: Tue, 27 Nov 2001 10:57:07 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: sekhar raja <manamraja@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Doubt in Kernel Timers
Message-Id: <20011127105707.15897491.johnpol@2ka.mipt.ru>
In-Reply-To: <20011127070845.55943.qmail@web14510.mail.yahoo.com>
In-Reply-To: <20011127083602.0d19d985.johnpol@2ka.mipt.ru>
	<20011127070845.55943.qmail@web14510.mail.yahoo.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 23:08:45 -0800 (PST)
sekhar raja <manamraja@yahoo.com> wrote:

> Do we need to Stop the timers if we want to Restart
> the timers with new expiry time. 

You must simply use mod_timer() to change timer expires time.

> I see in some implementations the timers are not
> stoped before before they restart. Is it correct?

T.e. they are *not* use del_timer() and after it add_timer() with new
expires time?
With del and add some races can arise.
It is correct to use mod_timer().

> 
> Thanks in Advance
> -Rajasekhar
> 
---
WBR. //s0mbre
