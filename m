Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRC0SSI>; Tue, 27 Mar 2001 13:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131473AbRC0SR7>; Tue, 27 Mar 2001 13:17:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:54795 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131472AbRC0SRm>; Tue, 27 Mar 2001 13:17:42 -0500
Date: Tue, 27 Mar 2001 15:15:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Michel Wilson <michel@procyon14.yi.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] OOM handling
In-Reply-To: <NEBBLEJBILPLHPBNEEHIKECICBAA.michel@procyon14.yi.org>
Message-ID: <Pine.LNX.4.33.0103271515210.26154-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Michel Wilson wrote:

> > relative ages.  The major flaw in my code is that a sufficiently
> > long-lived
> > process becomes virtually immortal, even if it happens to spring a serious
> > leak after this time - the flaw in yours is that system processes
>
> I think this could easily be fixed if you'd 'chop off' the runtime at a
> certain point:
>
> if(runtime > something_big)
> 	runtime = something_big;
>
> This would of course need some tuning. The only thing i don't
> like about this is that it's a kind of 'magical value',

This is the reason I used the sqrt approximation in my
OOM killer ;)

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

