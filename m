Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268139AbTBYTH0>; Tue, 25 Feb 2003 14:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268161AbTBYTH0>; Tue, 25 Feb 2003 14:07:26 -0500
Received: from crack.them.org ([65.125.64.184]:54942 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S268139AbTBYTHZ>;
	Tue, 25 Feb 2003 14:07:25 -0500
Date: Tue, 25 Feb 2003 14:17:11 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: atomic_t (24 bits???)
Message-ID: <20030225191711.GA25331@nevyn.them.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030225140554.20186A-100000@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1030225140554.20186A-100000@chaos>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 02:11:11PM -0500, Richard B. Johnson wrote:
> 
> In ../linux/include/asm/atomic.h, for versions 2.4.18 and
> above as far as I've checked, there are repeated warnings
> "Note that the guaranteed useful range of an atomic_t is
> only 24 bits."
> 
> I fail to see any reason why as atomic_t is typdefed to a
> volatile int which, on ix86 seems to be 32 bits.
> 
> Does anybody know if this is just some old comments from a
> previous atomic_t type of, perhaps, char[3]?  

There are other platforms where you can't reliably use the whole word. 
Some ARM atomic_t implementations are like this, although I don't know
if the one in the kernel is.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
