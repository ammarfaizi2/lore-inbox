Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAXUaY>; Wed, 24 Jan 2001 15:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRAXUaO>; Wed, 24 Jan 2001 15:30:14 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:766 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129444AbRAXUaL>; Wed, 24 Jan 2001 15:30:11 -0500
Date: Wed, 24 Jan 2001 14:30:10 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Cc: Linux MM mailing list <linux-mm@kvack.org>
In-Reply-To: <3A6F22D7.3000709@valinux.com>
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org>
Subject: Re: Page Attribute Table (PAT) support?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010124203012Z129444-18594+1042@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Wed, 24 Jan
2001 11:45:43 -0700


> I'm actually writing support for the PAT as we speak.  I already have 
> working code for PAT setup.  Just having a parameter for ioremap is not 
> enough, unfortunately.  According to the Intel Architecture Software 
> Developer's Manual we have to remove all mappings of the page that are 
> cached.

For our specific purposes, that's not important.  We already flush the cache
before we create uncached regions (via ioremap_nocache).  I understand that as a
general Linux feature, you can't ignore cache incoherency, but I don't think
it's a hard requirement.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
