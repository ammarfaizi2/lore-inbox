Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTGZCr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 22:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTGZCr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 22:47:28 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:4482
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S269191AbTGZCr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 22:47:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.4.21-ck3 in schedule
Date: Sat, 26 Jul 2003 13:06:45 +1000
User-Agent: KMail/1.5.2
References: <20030725051847.GA1778@triplehelix.org>
In-Reply-To: <20030725051847.GA1778@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261306.45743.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 15:18, Joshua Kwan wrote:
> 2.4.21-ck1 was fine under nearly the same circumstances. I rebuilt with
> a newer -ck when I was configuring my new ADSL bridge to work with Linux
> pppoe, but I doubt that's related.
>
> Anyway, it drove my wireless card driver nuts too, probably due to some
> busted interrupts. It kept printing a SW TICK STUCK? message. I'll
> revert to vanilla for now. :(

I suspect it's the variable Hz that is exported as 100 but runs as 1000 in 
2.4-ck. I suggest you build without the variable Hz and tuning so it runs at 
100Hz and try again.

Con

