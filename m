Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282884AbRLBOAP>; Sun, 2 Dec 2001 09:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282883AbRLBOAG>; Sun, 2 Dec 2001 09:00:06 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:43463 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S282884AbRLBN7w>;
	Sun, 2 Dec 2001 08:59:52 -0500
Date: Sun, 2 Dec 2001 14:59:46 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] floppy.c #defines
In-Reply-To: <Pine.LNX.4.33.0112021526530.3767-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.43.0112021455570.30813-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2 Dec 2001, Zwane Mwaikambo wrote:

> -#define ECALL(x) if ((ret = (x))) return ret;
> +#define ECALL(x) if ((ret = (x))) return ret

To prevent a dangling else problem, better make that

#define ECALL(x) do { if ((ret = (x))) return ret; } while(0)

Eric

