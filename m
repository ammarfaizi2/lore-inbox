Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273476AbRIWNXd>; Sun, 23 Sep 2001 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273522AbRIWNXX>; Sun, 23 Sep 2001 09:23:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31330 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273476AbRIWNXI>; Sun, 23 Sep 2001 09:23:08 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Bill Davidsen <davidsen@tmr.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L.0109211121100.19147-100000@imladris.rielhome.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Sep 2001 07:13:07 -0600
In-Reply-To: <Pine.LNX.4.33L.0109211121100.19147-100000@imladris.rielhome.conectiva>
Message-ID: <m166aa82zg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> > I would also like to have time to investigate what happens if the pages
> > associated with a program load are handled in larger blocks, meta-pages
> > perhaps, which would at least cause many to be loaded at once on a page
> > fault, rather than faulting them in one at a time.
> 
> This is an interesting thing, too. Something to look into for
> 2.5 and if it turns out simple enough we may even want to
> backport it to 2.4.

filemap_nopage already does all of this except put the page in the
page table.


Eric
