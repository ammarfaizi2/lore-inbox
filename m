Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUD3VVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUD3VVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUD3VVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:21:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:41743 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261232AbUD3VOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:14:21 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Joe Schulz <joe@spamfilter.de>, linux-kernel@vger.kernel.org
Subject: Re: Problem spawning init from script
Date: Sat, 1 May 2004 00:14:07 +0300
User-Agent: KMail/1.5.4
References: <c6suq3$ko7$1@sea.gmane.org>
In-Reply-To: <c6suq3$ko7$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405010014.07259.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 April 2004 10:21, Joe Schulz wrote:
> Hello world,
>
>
> for internal reasons I designed a custom boot procedure with two root
> partitions. One is booted by default and a script is executed via the
> "init=/sbin/initscript" kernel option.
>
> The script restrieves some information and depending on that information
> it decides whether the current boot should continue or some other
> partition is being mounted and boot continues on that.
>
> As the script involves the usage of USB storage, gpg, openssl, device
> mapper and various other bits, it would make some pretty big and hard
> to handle initrd so I decided to try it directly as described.
>
> Infortunately when the script tries to exec'ute either one init proces or
> the other at its end, the kernel always panics:
>
> Kernel panic: Attempted to kill init!

This typically means that process #1 exited. Kernel does not like that.
I always use 'exec /path/something' as the last command in my sh scripts
which I start instead of 'standard' /sbin/init.

Post your script.
--
vda

