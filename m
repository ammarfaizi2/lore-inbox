Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSLUHoC>; Sat, 21 Dec 2002 02:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSLUHoC>; Sat, 21 Dec 2002 02:44:02 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:34256 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S266771AbSLUHoC>; Sat, 21 Dec 2002 02:44:02 -0500
Date: Sat, 21 Dec 2002 08:52:05 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
Message-ID: <20021221075205.GZ31070@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021220114837.GC13591@charite.de> <20021220223754.GA10139@werewolf.able.es> <20021220225733.GE31070@charite.de> <20021221001334.GA7996@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021221001334.GA7996@werewolf.able.es>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* J.A. Magallon <jamagallon@able.es>:

> For user space memory, there is no real OOM state. The system (glibc) just
> does not give you the memory, returns NULL in the malloc, and it is your
> responsibility to check malloc's return value. If you do not check it,
> you try to access a null pointer and _bang_. So in your case, after enough
> iterations on malloc() without free(), it returns NULL and you fall into
> a null pointer dereference.

Ergo: Squid is br0ken.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Windows is the answer, but only if the question was 'what is the
intellectual equivalent of being a galley slave?' 

