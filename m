Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267800AbTBUXO5>; Fri, 21 Feb 2003 18:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267801AbTBUXO5>; Fri, 21 Feb 2003 18:14:57 -0500
Received: from b.smtp-out.sonic.net ([208.201.224.39]:29896 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S267800AbTBUXO4>; Fri, 21 Feb 2003 18:14:56 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Fri, 21 Feb 2003 15:25:02 -0800
From: David Hinds <dhinds@sonic.net>
To: joshk@triplehelix.org
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 weirdness
Message-ID: <20030221152502.A9282@sonic.net>
References: <20030221221814.GA1316@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221221814.GA1316@triplehelix.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 02:18:14PM -0800, Joshua Kwan wrote:
> 
> I was wondering if any people might know what is going on here. This
> happens in 2.5.62, using CardBus pcmcia support within my kernel and
> the latest pcmcia-cs snapshot.
> 
> Just to clarify, I have only one wifi card - wlan0.

It appears that someone broke the code for keeping track of sockets,
since the PCMCIA drivers are telling cardmgr that the same card is
inserted twice.

-- Dave
