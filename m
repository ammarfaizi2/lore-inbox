Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSEHT6u>; Wed, 8 May 2002 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315101AbSEHT6t>; Wed, 8 May 2002 15:58:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315091AbSEHT6s>; Wed, 8 May 2002 15:58:48 -0400
Subject: Re: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1)
To: dax@gurulabs.com (Dax Kelson)
Date: Wed, 8 May 2002 21:17:39 +0100 (BST)
Cc: chris@scary.beasts.org (chris@scary.beasts.org),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (marcelo@conectiva.com.br)
In-Reply-To: <Pine.LNX.4.44.0205081341160.10496-100000@mooru.gurulabs.com> from "Dax Kelson" at May 08, 2002 01:55:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175XsZ-0002IO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> prtctl(PR_SET_KEEPCAPS, 1)
> setuid(uid)
> setgid(gid)
> 
> The end result is exactly the same.  I'm trying to envision how this patch
> would change security in a negative way.  I keep coming back to the Unix
> idea of "don't be smarter than the admin; don't try to protect root from
> himself". 
> 
> Maybe we could enchance PR_SET_KEEPCAPS so that:
> 
> prtctl(PR_SET_KEEPCAPS, 2) kept both the permitted and the effective caps.

If thats the concern (and its a fair one) then just fix 2.5 not 2.4. 2.4
stuff will need to do the usermode fixes anyway due to old releases
