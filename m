Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268006AbTAIUde>; Thu, 9 Jan 2003 15:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268007AbTAIUde>; Thu, 9 Jan 2003 15:33:34 -0500
Received: from havoc.daloft.com ([64.213.145.173]:21455 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268006AbTAIUdd>;
	Thu, 9 Jan 2003 15:33:33 -0500
Date: Thu, 9 Jan 2003 15:42:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>, Corey Minyard <minyard@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: IPMI driver
Message-ID: <20030109204211.GA27752@gtf.org>
References: <200301090332.h093WML05981@hera.kernel.org> <20030109164407.GA26195@codemonkey.org.uk> <1042135594.27796.37.camel@irongate.swansea.linux.org.uk> <20030109172229.GA27288@codemonkey.org.uk> <1042135971.27796.44.camel@irongate.swansea.linux.org.uk> <3E1DCA8D.4040005@acm.org> <20030109192022.GA5693@codemonkey.org.uk> <1042143476.27796.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042143476.27796.66.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 08:17:57PM +0000, Alan Cox wrote:
> On Thu, 2003-01-09 at 19:20, Dave Jones wrote:
> > time_diff = ((jiffies_now - kcs_info->last_timeout_jiffies)
> 
> Thats valid for unsigned maths
> 	0x00000001 - 0xFFFFFFFF = 0x00000002

Just as a general note (not to Alan), this often appears in ethernet
drivers, in their RX and TX producer/consumer ring counters...  so don't
be surprised if you see this logic elsewhere in the kernel, too.

	Jeff



