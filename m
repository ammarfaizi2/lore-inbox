Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbUK3Vsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbUK3Vsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUK3Vsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:48:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:54204 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262339AbUK3Vsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:48:43 -0500
Date: Tue, 30 Nov 2004 22:58:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Bebel <bebel@braila.astral.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: misleading error message
In-Reply-To: <001101c4d715$25a59470$af00a8c0@BEBEL>
Message-ID: <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost>
References: <001101c4d715$25a59470$af00a8c0@BEBEL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Bebel wrote:

> This may be a BUG REPORT, as I see it, allthough more experienced Linux users
> might think differently:
> 
> I compiled built-in support for iptables in my new 2.6.9 kernel, but when my
> legacy firewall does a "modprobe ip_tables" , I get the startling message:
> "FATAL: module ip_tables not found" .

In my oppinion the message is perfectly clear. You told modprobe to load a 
module, the file was not found so it is forced to give up - and that's 
exactely what it told you.

modprobe knows nothing about the functionality provided by any given 
module, it's only task in life is to attempt to load modules you tell it 
to load. So, it cannot tell you that "I didn't find this and besides, you 
don't need it since it's already build in", since modprobe does not have 
that information. 

All modprobe can do is try to load the module you told it to load, and 
when the file is missing that *is* a fatal error from modrobes point of 
view - it has absolutely no way to recover or give you any sane 
diagnostics since it has no idea what the mystery module you asked it to 
load that wasn't there was supposed to do.


-- 
Jesper Juhl


