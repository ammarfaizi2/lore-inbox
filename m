Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbRFGU0M>; Thu, 7 Jun 2001 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbRFGU0D>; Thu, 7 Jun 2001 16:26:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58634 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263079AbRFGUZw>; Thu, 7 Jun 2001 16:25:52 -0400
Date: Thu, 7 Jun 2001 15:50:31 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Background scanning change on 2.4.6-pre1
Message-ID: <Pine.LNX.4.21.0106071545520.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, 


Who did this change to refill_inactive_scan() in 2.4.6-pre1 ? 

        /*
         * When we are background aging, we try to increase the page aging
         * information in the system.
         */
        if (!target)
                maxscan = nr_active_pages >> 4;

This is going to make all pages have age 0 on an idle system after some
time (the old code from Rik which has been replaced by this code tried to 
avoid that)

Could you please explain me the reasoning behind this change ?  

Thanks 

