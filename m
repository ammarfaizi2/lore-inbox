Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUFHKjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUFHKjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUFHKjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:39:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:64528 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264970AbUFHKjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:39:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Patric Ho <patric1972uk@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: kenel memory usage question.
Date: Tue, 8 Jun 2004 13:30:12 +0300
X-Mailer: KMail [version 1.4]
References: <20040608095730.39955.qmail@web25109.mail.ukl.yahoo.com>
In-Reply-To: <20040608095730.39955.qmail@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406081330.12995.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 June 2004 12:57, Patric Ho wrote:
> I am working on linux used in embedded devices. I use
> following method to calculate the actual amount of
> memory used by kernel+processes (not including page
> caches and swap is off in my system):
>
> (from /proc/meminfo) MemTotal - MemFree - Buffers -
> Cached.
>
> I thought this should be a fairly constant number for
> a minimal kernel, e.g. no network support, and
> statistics are collected right after login. However
> when I use different "mem=" kernel cmd-line option, I
> got quite different numbers:
>
> 7M: 2580K
> 8M: 2612K
> 16M: 2648K
> 128M: 3584K

some data tables are sized differently depending on RAM
size (TCP hash table etc. look into dmesg)

> Any idea why this happens? I can even see "Slab:"
> changes from 1220K when mem=7M to 1968K when mem=128K.
> It looks like kernel can adjust memory usage depends
> on the actual physical memory available. I previously
> thought only page caches can shrink in such way.
-- 
vda
