Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289326AbSBEBIx>; Mon, 4 Feb 2002 20:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289328AbSBEBIn>; Mon, 4 Feb 2002 20:08:43 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:32951 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289326AbSBEBIf>; Mon, 4 Feb 2002 20:08:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Robert Love <rml@tech9.net>
Subject: Re: current->state after kmalloc
Date: Tue, 5 Feb 2002 02:08:07 +0100
X-Mailer: KMail [version 1.3.2]
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <m16XtOG-000OVeC@amadeus.home.nl> <16Xthq-147i9wC@fwd04.sul.t-online.com> <1012870211.1062.43.camel@phantasy>
In-Reply-To: <1012870211.1062.43.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16Xu62-2F1K08C@fwd04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 February 2002 01:50, Robert Love wrote:
> On Mon, 2002-02-04 at 19:43, Oliver Neukum wrote:
> > Is it safe with GFP_ATOMIC ?
>
> You are guaranteed kmalloc will not sleep if you use GFP_ATOMIC, yes.
>
> But I still find it gross to mark yourself sleeping but not sleep
> immediately.

usb_submit_urb() uses kmalloc internally.
To code a simple waiting for the results of an urb,
it is necessary.

	Regards
		Oliver
