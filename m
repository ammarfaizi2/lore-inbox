Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131043AbQL2Mjk>; Fri, 29 Dec 2000 07:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131092AbQL2Mj3>; Fri, 29 Dec 2000 07:39:29 -0500
Received: from hermes.mixx.net ([212.84.196.2]:5901 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131043AbQL2MjM>;
	Fri, 29 Dec 2000 07:39:12 -0500
Message-ID: <3A4C7E3D.D18B3C34@innominate.de>
Date: Fri, 29 Dec 2000 13:06:21 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <Pine.LNX.4.21.0012282012480.12680-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Thu, 28 Dec 2000, Linus Torvalds wrote:
> 
> >  - make "SetPageDirty()" do something like
> >
> >       if (!test_and_set(PG_dirty, &page->flags)) {
> >               spin_lock(&page_cache_lock);
> >               list_del(page->list);
> >               list_add(page->list, page->mapping->dirty_pages);
> >               spin_unlock(&page_cache_lock);
> >       }
> 
> We also want to move the page to the per-address-space clean list in
> ClearPageDirty I suppose.

I'd like to suggest taking this opportunity to regularize the notation
by going to set_page_dirty/clear_page_dirty which will call
SetPageDirty/ClearPageDirty.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
