Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQLAKAg>; Fri, 1 Dec 2000 05:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbQLAKA0>; Fri, 1 Dec 2000 05:00:26 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:54006 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129414AbQLAKAL>;
	Fri, 1 Dec 2000 05:00:11 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001130203703Z129437-440+118@vger.kernel.org> 
In-Reply-To: <20001130203703Z129437-440+118@vger.kernel.org>  <200011301803.eAUI3Pu16137@webber.adilger.net> 
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pls add this driver to the kernel tree !! 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Dec 2000 09:26:29 +0000
Message-ID: <24827.975662789@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ttabi@interactivesi.com said:
>  Not necessarily - it all depends on what your driver does.  In many
> cases, supporting 2.2 and 2.4 is easy, and all you need are a few
> #if's.  It's certainly much better to have a dozen or so #if's
> sprinkled throughout the code than to have two separate source trees,
> and have to make the same change to multiple files.

It's even better to do it without the ugly preprocessor magic - see 
include/linux/compatmac.h

There are a few things missing from there - include/linux/mtd/compatmac.h 
has more. One day we'll get round to removing the latter and merging it 
into the main one, hopefully. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
