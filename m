Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268617AbRHPBj5>; Wed, 15 Aug 2001 21:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268660AbRHPBjs>; Wed, 15 Aug 2001 21:39:48 -0400
Received: from ns.suse.de ([213.95.15.193]:64524 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268617AbRHPBjb>;
	Wed, 15 Aug 2001 21:39:31 -0400
To: Manfred Bartz <mbartz@optushome.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: connect() does not return ETIMEDOUT
In-Reply-To: <Pine.LNX.4.21.0108151123510.4809-100000@w-sridhar2.des.sequent.com.suse.lists.linux.kernel> <20010816005902.16224.qmail@optushome.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Aug 2001 03:39:42 +0200
In-Reply-To: Manfred Bartz's message of "16 Aug 2001 03:09:27 +0200"
Message-ID: <oupvgjog4v5.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Bartz <mbartz@optushome.com.au> writes:
> 
> But in reality and going by the tcpdump, an unlimited number of
> connections is accepted because the server side completes the 3-way
> handshake regardless.  The connections are then lost later (with a
> different error message).  This does not look right to me.

The default is upto 128 queued syns before stopping acks, or an unlimited 
number when syncookies are turned on. You can change both with the 
tcp_max_syn_backlog or tcp_syncookies sysctls. 

-Andi

