Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWEFLHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWEFLHf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 07:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWEFLHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 07:07:35 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21452 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750747AbWEFLHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 07:07:34 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 8/14] random: Remove SA_SAMPLE_RANDOM from USB gadget drivers
Date: Sat, 6 May 2006 14:07:02 +0300
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net
References: <9.420169009@selenic.com>
In-Reply-To: <9.420169009@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605061407.02737.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 19:42, Matt Mackall wrote:
> Remove SA_SAMPLE_RANDOM from USB gadget drivers
> 
> There's no a priori reason to think that USB device interrupts will
> contain "entropy" as defined/required by /dev/random. In fact, most
> operations will be streaming and bandwidth- or CPU-limited.
> /dev/random needs unpredictable inputs such as human interaction or
> chaotic physical processes like turbulence manifested in disk seek
> times.

You may remove SA_SAMPLE_RANDOM from disk interrupts on the same grounds,
because flash-based "IDE" drives have no seek. Indeed, with careful
choice of components, setup, and placement of sniffing equipment
you may construct a case where you can predict interrupt times.

But it's too artificial to matter in real life.

Come on, let's get real. A few low bits of TSC are random enough
(for just about any interrupt source).

Attackers will probably look for easier ways to hack your crypto
than predicting /dev/random.
--
vda
