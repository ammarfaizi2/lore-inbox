Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270347AbRIFLXi>; Thu, 6 Sep 2001 07:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272450AbRIFLX2>; Thu, 6 Sep 2001 07:23:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26129 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270347AbRIFLXT>;
	Thu, 6 Sep 2001 07:23:19 -0400
Date: Thu, 6 Sep 2001 08:23:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <E15eMl6-0004Rn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0109060822350.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Alan Cox wrote:

> > Pages allocated with do_anonymous_page are not added to the active list.
> > as a result there is no aging information for a page until it is
> > unmapped. So we might be unmapping and allocating swap for shared pages
>
> Right ok.

One problem though, we cannot 'see' the referenced bits in the
page tables and nothing else is accessing this page, so there's
no information we can learn from having this page on the active
list.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

