Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274863AbRIUWvG>; Fri, 21 Sep 2001 18:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274866AbRIUWu4>; Fri, 21 Sep 2001 18:50:56 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:3743 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S274863AbRIUWup>;
	Fri, 21 Sep 2001 18:50:45 -0400
Date: Sat, 22 Sep 2001 00:50:51 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems, kupdated bugfixes
Message-ID: <20010922005051.A5360@schmorp.de>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010921221225.A22402@schmorp.de> <Pine.LNX.4.33L.0109211757050.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109211757050.19147-100000@imladris.rielhome.conectiva>
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 05:57:36PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> On the contrary, when you have a bunch of small files to sync
> you just allocate them next to each other and flush them all
> at once ;)

Different layer really: The idea was to sync blocks contiguous to the
dirty block we want to sync (regardless of filesystem, i.e. similar to
the elevator which also works at abelow-the-fs-level). (Allocated) block
numbers are necessary for this to work.

(but i don't know how relevant this is in practise. I think it might gain
a lot, though, but that doesn't mean much ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
