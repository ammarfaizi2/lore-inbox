Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289490AbSBEIgP>; Tue, 5 Feb 2002 03:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289374AbSBEIgE>; Tue, 5 Feb 2002 03:36:04 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:5861 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289364AbSBEIfz>; Tue, 5 Feb 2002 03:35:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: arjan@fenrus.demon.nl
Subject: Re: current->state after kmalloc
Date: Tue, 5 Feb 2002 09:35:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m16Y0mA-000OVeC@amadeus.home.nl>
In-Reply-To: <m16Y0mA-000OVeC@amadeus.home.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16Y14r-21sp8aC@fwd05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 February 2002 09:16, arjan@fenrus.demon.nl wrote:
> In article <16Xu62-2F1K08C@fwd04.sul.t-online.com> you wrote:
> > usb_submit_urb() uses kmalloc internally.
> > To code a simple waiting for the results of an urb,
> > it is necessary.
>
> Can't you just alloc the memory outside this "current" area ?
> Even if that means you have to release it if you don't use it

No. The individual USB device drivers must not know the memory
requirements of the HCD layer.

	Regards
		Oliver

