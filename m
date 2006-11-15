Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030872AbWKOTAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030872AbWKOTAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030879AbWKOTAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:00:43 -0500
Received: from gw.goop.org ([64.81.55.164]:37524 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030872AbWKOTAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:00:42 -0500
Message-ID: <455B63D8.7000601@goop.org>
Date: Wed, 15 Nov 2006 11:00:40 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu> <455B5ED8.5090005@goop.org> <20061115184315.GA5078@elte.hu> <455B611C.3010503@goop.org> <20061115184936.GA6389@elte.hu>
In-Reply-To: <20061115184936.GA6389@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i'd not even use glibc's %gs but set up two separate selectors. (that's 
> a more controlled experiment - someone might run a non-TLS glibc, etc.)
>   

Well, in that case they probably don't care whether the kernel uses %fs
or %gs ;)

But either way, this doesn't have much bearing on Eric's test; we'd be
only talking about a few ns per kernel exit, rather than 5% for read/write.

    J
