Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWAMGnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWAMGnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 01:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWAMGnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 01:43:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751514AbWAMGnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 01:43:24 -0500
Date: Thu, 12 Jan 2006 22:43:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: linux-2.6.15-git7: PS/2 keyboard dies on ppp traffic
Message-Id: <20060112224301.74b8875f.akpm@osdl.org>
In-Reply-To: <43C66E82.4030106@ums.usu.ru>
References: <43C66E82.4030106@ums.usu.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
>
> the main linux tree started suffering the same bug as described for -mm 
>  earlier in http://lkml.org/lkml/2005/11/7/147:
> 
>  if I put load on my system, connect to the Internet using my cellphone 
>  (/dev/ttyS0) and do something, it stops reacting to PS/2 keyboard 
>  events, but still understands PS/2 mouse. The PPP load monitor shows 
>  huge transfer rate (several megabytes per second) consisting of the 
>  infinitely replicated several last packets. events/0 consumes all the 
>  CPU. tty buffering revamping patch is the obvious candidate, but I 
>  haven't tried to revert it yet.

Darn, I hadn't thought of that.  Yes tty-revamp might be the culprit.

Which serial driver are you using?   Just 8250?

For you convenience,
http://www.zip.com.au/~akpm/linux/patches/stuff/2615mm2-no-tty-revamp.bz2
is 2.6.15-mm2 with just the tty-revamp and isicom patches reverted.

