Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSE3PRQ>; Thu, 30 May 2002 11:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316690AbSE3PRP>; Thu, 30 May 2002 11:17:15 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:15039 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316686AbSE3PRN>; Thu, 30 May 2002 11:17:13 -0400
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: large copy_to_user fills only one page?
In-Reply-To: <7wofexu2hl.fsf@avalon.france.sdesigns.com>
From: Andi Kleen <ak@muc.de>
Date: 30 May 2002 17:16:53 +0200
Message-ID: <m3adqhll7e.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Michon <emmanuel_michon@realmagic.fr> writes:

> case DOGRAB:
>         char *u_p,*k_p;
>         copy_from_user(u_p,arg,sizeof(char *));
                         ^^^
You copy into random stack garbage here. After that it goes downwards.

-Andi
