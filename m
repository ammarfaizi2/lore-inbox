Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLBA06>; Fri, 1 Dec 2000 19:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLBA0s>; Fri, 1 Dec 2000 19:26:48 -0500
Received: from mnh-1-17.mv.com ([207.22.10.49]:4362 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129257AbQLBA0f>;
	Fri, 1 Dec 2000 19:26:35 -0500
Message-Id: <200012020104.UAA05273@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "T. Camp" <campt@openmars.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II) 
In-Reply-To: Your message of "Fri, 01 Dec 2000 15:35:05 PST."
             <Pine.LNX.4.21.0012011529070.4856-100000@magic.skylab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Dec 2000 20:04:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

campt@openmars.com said:
> I was unsure if it was okay to be using kmalloc during early stages of
> init/main.c so I decided to follow the example allready set and just
> use a static array - can anyone advise on being able to do this
> dynamically? 

kmalloc is usable after mem_init(), I think.  Before that, you can use the 
boot memory allocator (see mm/bootmem.c).  In the arch that I'm most familiar 
with (arch/um), that is usable from the beginning of start_kernel.  I don't 
know about the other arches.

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
