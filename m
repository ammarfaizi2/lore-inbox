Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265405AbRF2Cau>; Thu, 28 Jun 2001 22:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbRF2Cak>; Thu, 28 Jun 2001 22:30:40 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:36356 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265405AbRF2Cab>;
	Thu, 28 Jun 2001 22:30:31 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: torvalds@transmeta.com (Linus Torvalds),
        patrick@dreker.de (Patrick Dreker),
        dwmw2@infradead.org (David Woodhouse), jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
In-Reply-To: Your message of "Thu, 28 Jun 2001 18:14:15 +0100."
             <E15FfMt-0007Ht-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jun 2001 12:30:24 +1000
Message-ID: <16616.993781824@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001 18:14:15 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>Q: Would it be worth making the module author/version strings survive in
>a non modular build but stuffed into their own section so you can pull them
>out with some magic that we'd include in 'REPORTING-BUGS'

Bloats the running kernel.  Startup messages should be issued by __init
code and the messages should be __initdata.  There is no point in
holding onto those strings after boot.

