Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSCDLVE>; Mon, 4 Mar 2002 06:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSCDLUy>; Mon, 4 Mar 2002 06:20:54 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:2965 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290843AbSCDLUq>;
	Mon, 4 Mar 2002 06:20:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] moving task_struct
Date: Mon, 4 Mar 2002 12:16:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0203012040220.32042-100000@serv> <3C7FEAC9.DDA73021@mandrakesoft.com>
In-Reply-To: <3C7FEAC9.DDA73021@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hqRx-0000cv-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 1, 2002 09:55 pm, Jeff Garzik wrote:
> > The patch below simply moves task_struct into its own header file.
> > This makes thread_info and task_struct indepedent from sched.h and will 
> > allows archs to decide themselves the dependencies between these
> > structures.
> 
> nice...   In addition to your second patch, this first patch may be a
> small step in paving the way for further unraveling of nasty include
> dependencies.

Apropo of that, struct page needs to be defined before mmzone.h is
included, so that inlines in mmzone.h can do arithmetic involving
sizeof(struct page), instead of using macros.

-- 
Daniel
