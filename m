Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbTGHQcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267490AbTGHQcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:32:54 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:23479 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S267488AbTGHQcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:32:52 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200307081647.UAA13391@dub.inr.ac.ru>
Subject: Re: tc stack overflow
To: linux-kernel@vger.kernel.org
Date: Tue, 8 Jul 2003 20:47:19 +0400 (MSD)
Cc: creatix@hipac.org
In-Reply-To: <200307081640.UAA28623@th.inr.ac.ru> from "A.N.Kuznetsov" at  =?ISO-8859-1?Q?=20=E9?=
	=?ISO-8859-1?Q?=C0=CC?= 08, 2003 08:40:05 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> # tc qdisc add dev eth0 root handle 1: prio \
>    for i in `seq 500` ; do tc qdisc add dev eth0 \
>        parent $i:1 handle `expr $i + 1`: prio ; done ; \
>    ping 1.2.3.4
> 
> [replace eth0 by a device of your choice]

... or replace too complicated script with cp /dev/zero /dev/mem. :-)


> So, what do you think about the issue? Do you care?

I do not. Yes, it is real design mistake, recursion is always evil.
Maybe, it will be remade some day. But until that day it does not matter.

Alexey
