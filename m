Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUBKOFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUBKOFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:05:51 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:29201 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264376AbUBKOFp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:05:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Maciej Zenczykowski <maze@cela.pl>, wdebruij@dds.nl
Subject: Re: printk and long long
Date: Wed, 11 Feb 2004 16:04:48 +0200
X-Mailer: KMail [version 1.4]
Cc: sting sting <zstingx@hotmail.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402111448320.10791-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0402111448320.10791-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 February 2004 15:48, Maciej Zenczykowski wrote:
> > how about simply using a shift to output two regular longs, i.e.
> >
> > printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8
> > >> sizeof(long) * 8);
>
> I'd venture to guess you'd also have to cast the above to long.

Hey that will work only for %x, not %d.

BTW, man printf says:

The character L specifying that a following e, E, f, g, or G
conversion corresponds to a long double argument, or a following
d, i, o, u, x, or X conversion corresponds to a long long argument.
Note that long long is not specified in ANSI C and therefore
not portable to all architectures.
--
vda
