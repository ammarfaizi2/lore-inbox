Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSACMPS>; Thu, 3 Jan 2002 07:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287188AbSACMPI>; Thu, 3 Jan 2002 07:15:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287130AbSACMO4>; Thu, 3 Jan 2002 07:14:56 -0500
Subject: Re: [PATCH] expanding truncate
To: green@namesys.com (Oleg Drokin)
Date: Thu, 3 Jan 2002 12:25:34 +0000 (GMT)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <20020103102128.A2625@namesys.com> from "Oleg Drokin" at Jan 03, 2002 10:21:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M6wB-00089t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     This patch makes sure that indirect pointers for holes are correctly filled in by zeroes at
>     hole-creation time. (Author is Chris Mason. fs/buffer.c part (generic_cont_expand) were written by
>     Alexander Viro)

Why is that even needed. If you truncate a file larger it doesn't need to
fill in the datablocks until they are touched surely
