Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293743AbSCFSWO>; Wed, 6 Mar 2002 13:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293747AbSCFSWC>; Wed, 6 Mar 2002 13:22:02 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:47112 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293743AbSCFSVz>;
	Wed, 6 Mar 2002 13:21:55 -0500
Date: Wed, 6 Mar 2002 15:09:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bulent Abali <abali@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct page shrinkage
In-Reply-To: <OF8A6868F1.312B7C40-ON85256B74.005CB22E@pok.ibm.com>
Message-ID: <Pine.LNX.4.44L.0203061508080.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Bulent Abali wrote:
> >Rik van Riel wrote:
> >>
> >> +               clear_bit(PG_locked, &p->flags);
> >
> >Please don't do this.  Please use the macros.  If they're not
> >there, please create them.
> >
> >Bypassing the abstractions in this manner confounds people
> >who are implementing global locked-page accounting.
>
> I have an application which needs to know the total number of locked and
> dirtied pages at any given time.  In which application locked-page
> accounting is done?   I don't see it in base 2.5.5.   Are there any patches
> or such that you can give pointers to?

You could modify lock_page to do statistics. This is
made easier if you are sure that every driver uses
lock_page / LockPage and UnlockPage

I'm happy Andrew made me clean up the drivers instead
of just fixing them ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

