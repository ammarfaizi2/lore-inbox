Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUALUTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266235AbUALUTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:19:09 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:3268 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S266206AbUALUTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:19:06 -0500
Subject: Re: 2.6.1: modprobe behaves strange
From: David T Hollis <dhollis@davehollis.com>
To: Detlef Grittner <detlef.grittner@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4002FF88.3000303@t-online.de>
References: <4002FF88.3000303@t-online.de>
Content-Type: text/plain
Message-Id: <1073938737.23741.1.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 12 Jan 2004 15:19:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 15:11, Detlef Grittner wrote:
> Hello,
> 
> I'm using the x86_64 architecture branch and have simply copied the 
> kernel into my configuration of a 2.4.21 kernel.
> 
> I have the following lines in /etc/modules.conf:
> 
> alias eth0 r8169
> 
> alias snd-card-0 snd-via82xx
> 
> With the 2.4.21 kernel everything worked fine, with the 2.6.1 kernel I 
> get the following behavior:
> 
> modprobe eth0
> (no error, but r8169 not loaded)
> 
> modprobe r8169
> (module r8169 is loaded and works)
> 
> modprobe snd-card-0
> (FATAL: Modul snd_card_0 not found)
> 
> modprobe snd-via82xx
> (module snd-via82xx is loaded and works)
> 
Seems that you do have module_init_tools so you are fine there, but you
are editing /etc/modules.conf.  On a 2.6 kernel using module_init_tools,
you need to use /etc/modprobe.conf.  

So we've gone from conf.modules to modules.conf to modprobe.conf.  Keeps
things interesting!

-- 
David T Hollis <dhollis@davehollis.com>

