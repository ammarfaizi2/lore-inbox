Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSKRW3T>; Mon, 18 Nov 2002 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKRW2w>; Mon, 18 Nov 2002 17:28:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19215 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265336AbSKRW1o>;
	Mon, 18 Nov 2002 17:27:44 -0500
Date: Mon, 18 Nov 2002 22:34:45 +0000
From: Matthew Wilcox <willy@debian.org>
To: george anzinger <george@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@gamebox.net>,
       Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Run timers as softirqs, not tasklets
Message-ID: <20021118223445.R7530@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0211172108160.12550-100000@localhost.localdomain> <3DD969B6.9D221DB1@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD969B6.9D221DB1@mvista.com>; from george@mvista.com on Mon, Nov 18, 2002 at 02:29:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 02:29:10PM -0800, george anzinger wrote:
> So then, is there any reason to not put them ahead of
> HI_SOFTIRQ?  I.e.:
> 
>  enum
>  {
>         TIMER_SOFTIRQ=0,
>  	HI_SOFTIRQ
>         NET_TX_SOFTIRQ,
>         NET_RX_SOFTIRQ,
>         SCSI_SOFTIRQ,

because then there would be no way to make a tasklet run before the timers?
turn it around.  convince us that timers should run first.

-- 
Revolutions do not require corporate support.
