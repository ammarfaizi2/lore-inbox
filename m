Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbRGIJcS>; Mon, 9 Jul 2001 05:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbRGIJcI>; Mon, 9 Jul 2001 05:32:08 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:55496 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S266996AbRGIJbu>; Mon, 9 Jul 2001 05:31:50 -0400
From: Christoph Rohland <cr@sap.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107091107490.311-100000@mikeg.weiden.de>
Organisation: SAP LinuxLab
Date: 09 Jul 2001 11:29:48 +0200
In-Reply-To: <Pine.LNX.4.33.0107091107490.311-100000@mikeg.weiden.de>
Message-ID: <m38zhya1rn.fsf@linux.local>
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

Hi Mike,

On Mon, 9 Jul 2001, Mike Galbraith wrote:
> --- mm/shmem.c.org	Mon Jul  9 09:03:27 2001
> +++ mm/shmem.c	Mon Jul  9 09:03:46 2001
> @@ -264,8 +264,8 @@
>  	info->swapped++;
> 
>  	spin_unlock(&info->lock);
> -out:
>  	set_page_dirty(page);
> +out:
>  	UnlockPage(page);
>  	return error;
>  }
> 
> So, did I fix it or just bust it in a convenient manner ;-)

... now you drop random pages. This of course helps reducing memory
pressure ;-)

But still this may be a hint. You are not running out of swap, aren't
you?

Greetings
		Christoph


