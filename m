Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271857AbRIQRG0>; Mon, 17 Sep 2001 13:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271865AbRIQRGR>; Mon, 17 Sep 2001 13:06:17 -0400
Received: from intranet.resilience.com ([209.245.157.33]:21889 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S271857AbRIQRGE>; Mon, 17 Sep 2001 13:06:04 -0400
Mime-Version: 1.0
Message-Id: <p05100303b7cbdde50ddd@[10.128.7.49]>
In-Reply-To: <Pine.LNX.3.95.1010917123904.14830A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010917123904.14830A-100000@chaos.analogic.com>
Date: Mon, 17 Sep 2001 10:06:21 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:42 PM -0400 2001-09-17, Richard B. Johnson wrote:
>  > What is the intent behind this "rep;nop" ? Does it really rely on an
>  > undocumented behaviour ?
>
>Well it's now documented although you have to search a web-site to
>find it. Basically, it runs the CPU at low clock-speed when it's
>busy-waiting. Since most all spin-locks lock for mere microseconds
>it's unlikely that it does anything useful, but it can't hurt.

Sounds like a good opportunity for a comment....
-- 
/Jonathan Lundell.
