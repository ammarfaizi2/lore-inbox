Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264627AbSJTTao>; Sun, 20 Oct 2002 15:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSJTTao>; Sun, 20 Oct 2002 15:30:44 -0400
Received: from zork.zork.net ([66.92.188.166]:60131 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S264627AbSJTTan>;
	Sun, 20 Oct 2002 15:30:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Error in get_swap_page? (2.5.44)
References: <20021020213217.A17457@jaquet.dk>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DRUGS/ALCOHOL, NON-SEQUITUR
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 20 Oct 2002 20:36:46 +0100
In-Reply-To: <20021020213217.A17457@jaquet.dk> (Rasmus Andersen's message of
 "Sun, 20 Oct 2002 21:32:17 +0200")
Message-ID: <6ud6q4x5pt.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Rasmus Andersen quotation:

> Unless I am mistaken, we return stuff (entry) from the local 
> stack in swapfile.c::get_swap_page. Am I mistaken?

Wouldn't this only be a problem if a *pointer* to it was being
returned?

> Code in question:
>
> swp_entry_t get_swap_page(void)
> {
>         struct swap_info_struct * p;
>         unsigned long offset;
>         swp_entry_t entry;
>         int type, wrapped = 0;
>
>         entry.val = 0;  /* Out of memory */
> [...]
>
> out:
>         swap_list_unlock();
>         return entry;
> }

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
