Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272676AbTHEMNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272681AbTHEMNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:13:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15745 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272676AbTHEMNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:13:11 -0400
Date: Tue, 5 Aug 2003 08:14:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Rafael Costa dos Santos <rafael@thinkfreak.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Module Programming
In-Reply-To: <200308050838.49544.rafael@thinkfreak.com.br>
Message-ID: <Pine.LNX.4.53.0308050808350.4731@chaos>
References: <200308050838.49544.rafael@thinkfreak.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Rafael Costa dos Santos wrote:

> Where can I follow the modifications under the main functions of linux kernel
> programming between versions of kernerl?
>
> I am asking that because I have some work on that area and I want it to be
> portable to every kernel versions.
>

Well you can't be "portable to every kernel version", but you
can design your modules so that they will compile and run on
every version that supports modules.

The easiest thing is to try to compile your module, designed for
an older version, using a newer version of kernel headers. You
can then "fix" things that don't compile. You fix them inside
some compiler conditionals so they are not "fixed", hense broken,
for previous versions.

If you have a lot of modules, then you probably should make a
'configure' program or script that sets the proper conditionals
in some dynamic header file, based upon the kernel version.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

