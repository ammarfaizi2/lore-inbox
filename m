Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTDGPWt (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTDGPWt (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:22:49 -0400
Received: from ns.javad.ru ([62.105.138.7]:55819 "EHLO ns.javad.ru")
	by vger.kernel.org with ESMTP id S263441AbTDGPWs (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:22:48 -0400
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modifying line state manually on ttyS
References: <200304071702.08114.freesoftwaredeveloper@web.de>
X-attribution: osv
From: Sergei Organov <osv@javad.ru>
Date: 07 Apr 2003 19:34:25 +0400
In-Reply-To: <200304071702.08114.freesoftwaredeveloper@web.de>
Message-ID: <87d6jyiany.fsf@osv.javad.ru>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <freesoftwaredeveloper@web.de> writes:
> Hi.
> 
> I have asked in many other mailing-lists, but I got no good
> solution for my problem, so I try to ask here, although it may
> not be the exaclty correct list for it.
> 
> I have developed my own device, that is connected to ttyS0.
> To talk to my device, I need to set the state of the TxD line
> manually to either 0 or 1 (+12v or -12v). What I try to say is,
> I don't want to write a whole byte to the port, but only one single
> bit, that then stays persistent on the line, until I reset its state.
> Better sayed, I want to handle TxD line, like it's possible for
> DTR-line for example.

Do ioctl(fd, TIOCSBRK, 0) / ioctl(fd, TIOCCBRK, 0) help?

-- 
Sergei.

