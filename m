Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTKXPNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTKXPNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:13:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8722 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S263717AbTKXPNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:13:12 -0500
Date: Mon, 24 Nov 2003 16:13:07 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Breno <brenosp@brasilsec.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Force Coredump
Message-ID: <20031124151307.GA25193@alpha.home.local>
References: <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br> <20031124133120.GA13678@cambrant.com> <002301c3b291$9a2f50a0$34dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002301c3b291$9a2f50a0$34dfa7c8@bsb.virtua.com.br>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 11:48:10AM -0200, Breno wrote:
> Done , but no coredump file
> 
> %ulimit -c unlimited
> %./test
> Segmention fault
> %ls -lisa
> test*    test.c

You also need read permissions on the executable itself (it must be dumpable).
BTW, have you checked /proc/sys/kernel/core* ? Perhaps there's a pattern which
references a directory in which you have no permissions ?

HTH,
Willy

