Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSLMKrw>; Fri, 13 Dec 2002 05:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSLMKrw>; Fri, 13 Dec 2002 05:47:52 -0500
Received: from CPE-203-51-35-111.nsw.bigpond.net.au ([203.51.35.111]:1011 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S261874AbSLMKrv>; Fri, 13 Dec 2002 05:47:51 -0500
Message-ID: <3DF9BCAA.C96AA165@eyal.emu.id.au>
Date: Fri, 13 Dec 2002 21:55:38 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-rmap15b - compile failure
References: <Pine.LNX.4.50L.0212122349520.17748-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a failure building NVIDIA_kernel/nv.c (the nvidia driver):
http://download.nvidia.com/XFree86_40/1.0-4191/NVIDIA_kernel-1.0-4191.tar.gz

It uses
	pte = *pte_offset(pg_mid_dir, address);
but this patch removes pte_offset().

1) what is the correct fix (use pte_offset_kernel?)?

2) in general, is it wise to remove pte_offset() or should it
   be left for compatability?

I should clearly say that I am not familiar with the workings of this
patch, but find that it is likely to break drivers that are not in
the kernel tree (assuming you patch them).

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
