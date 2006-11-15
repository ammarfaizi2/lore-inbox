Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030867AbWKOStG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030867AbWKOStG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030865AbWKOStF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:49:05 -0500
Received: from gw.goop.org ([64.81.55.164]:40079 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030863AbWKOStB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:49:01 -0500
Message-ID: <455B611C.3010503@goop.org>
Date: Wed, 15 Nov 2006 10:49:00 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu> <455B5ED8.5090005@goop.org> <20061115184315.GA5078@elte.hu>
In-Reply-To: <20061115184315.GA5078@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> but it does not actually use the 'normal usermode TLS selector' - it 
> only loads it.
>
> a meaningful test would be to allocate two selector values and load and 
> read+write memory through both of them.
>   

Well, obviously in one case it would need to switch between
null/non-null/null.  But yes, good point about using the "usermode" %gs
each iteration.  I'll do some more tests.

    J
