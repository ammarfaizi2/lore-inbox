Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284842AbRLKDOL>; Mon, 10 Dec 2001 22:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284849AbRLKDOC>; Mon, 10 Dec 2001 22:14:02 -0500
Received: from adsl-63-195-80-148.dsl.snfc21.pacbell.net ([63.195.80.148]:8834
	"EHLO pincoya.com") by vger.kernel.org with ESMTP
	id <S284842AbRLKDNn> convert rfc822-to-8bit; Mon, 10 Dec 2001 22:13:43 -0500
Date: Mon, 10 Dec 2001 19:16:30 -0800
From: Gordon Oliver <gordo@pincoya.com>
To: Robert Love <rml@tech9.net>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] console close race fix resend
Message-ID: <20011210191630.A13679@furble>
Reply-To: gordo@pincoya.com
In-Reply-To: <1008035512.4287.1.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1008035512.4287.1.camel@phantasy>; from rml@tech9.net on Mon, Dec 10, 2001 at 17:51:51 -0800
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.12.10 17:51 Robert Love wrote:
> Marcelo,
> 
> [ Resend of previous patch, now against pre8.  Note it (a) is a bug fix
> and (b) was in Alan's tree ]

and (c) appears to still have a race... You should extract
the value from the structure inside the lock, otherwise you
will still race with con_close (though perhaps a smaller race)
but since the call to acquire_console_sem() can sleep, the
vt handle you have may be stale.

> Please, for all that is righteous, apply.

please fix it better first...
(unless I am mistaken).
	-gordo

