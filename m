Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUEZMd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUEZMd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbUEZMd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:33:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265544AbUEZMd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:33:56 -0400
Date: Wed, 26 May 2004 08:33:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Buddy Lumpkin <b.lumpkin@comcast.net>
cc: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>,
       orders@nodivisions.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
In-Reply-To: <S265514AbUEZMDj/20040526120339Z+1733@vger.kernel.org>
Message-ID: <Pine.LNX.4.53.0405260813440.858@chaos>
References: <S265514AbUEZMDj/20040526120339Z+1733@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gentlemen,

There is not enough RAM address-space in even 64-bit machines
to do a sort/merge of even a typical inventory with all the
keys present in RAM. So you need multiple tasks, each with
as much of the 64-bit address-space occupied by RAM, as
possible. Even then, you need to do partial sorts, etc.

It's not "bloat-ware" that requires getting as much free RAM
as possible for an application, but the business of doing business.
So, performance of data-intensive work such as the sort/merge
is improved by writing the contents of sleeping tasks RAM to
a storage device and using that RAM. It's just that simple.

Many years ago, there was a small company that tried to sell
a sort/merge engine (a dedicated CPU) to Digital because the
problems with handling large databases was well known and
interactive performance on VAX/11-750 machines sucked when
database applications were being run (because their pages
were being swapped). Of course the NIH syndrome took its
toll and nobody ever got such an engine. The result being
that everybody has performance problems when database
operations are being run --even today, with different
machines.

Any data-intensive application needs as much RAM as possible and
that's never quite enough for best performance.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


