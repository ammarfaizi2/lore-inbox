Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbRGITrQ>; Mon, 9 Jul 2001 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbRGITrG>; Mon, 9 Jul 2001 15:47:06 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:16113 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S264856AbRGITqq>; Mon, 9 Jul 2001 15:46:46 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107090915310.14024-100000@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 09 Jul 2001 21:44:44 +0200
In-Reply-To: <Pine.LNX.4.33.0107090915310.14024-100000@penguin.transmeta.com>
Message-ID: <m3g0c5c2fn.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 9 Jul 2001, Linus Torvalds wrote:
> Does it help if you just remove the
> 
> 	if (atomic_read(&page->count) > 2)
> 		goto out;
> 
> from shmem_writepage()?
> 
> It _shouldn't_ matter (because writepage() should only be called
> with inactive pages anyway), but your problem certainly sounds like
> your inactive dirty list is not able to write out shmfs pages.

No, it does matter. It prevents races against getpage.

Greetings
		Christoph


