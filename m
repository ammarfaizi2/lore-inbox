Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbQJaQBH>; Tue, 31 Oct 2000 11:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbQJaQA5>; Tue, 31 Oct 2000 11:00:57 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:51978 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129258AbQJaQAo>; Tue, 31 Oct 2000 11:00:44 -0500
Date: Tue, 31 Oct 2000 12:02:03 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Geoff Winkless <geoff@farmline.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
In-Reply-To: <06e301c04351$2eadd4d0$1400000a@farmline.com>
Message-ID: <Pine.LNX.4.21.0010311158490.1475-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Geoff Winkless wrote:

> "Alan Cox" <alan@lxorguk.ukuu.org.uk> writes:
> [about what I wrote]
> > > > VM: do_try_to_free_pages failed for httpd...
> > > > VM: do_try_to_free_pages failed for httpd...
> >
> > These if they are odd ones and the box continues are fine, if you get
> masses
> > of them then probably not
> 
> What's it actually doing when this happens? Would it help to allocate more
> VM?

This means try_to_free_pages() function (obviously this function tries to
free pages :)) failed to free any page. 

The process will probably free pages (or found free pages around) on the
next run(s) of try_to_free_pages. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
