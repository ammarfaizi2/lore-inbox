Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280669AbRKBMwB>; Fri, 2 Nov 2001 07:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKBMvx>; Fri, 2 Nov 2001 07:51:53 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:776 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280669AbRKBMvo>; Fri, 2 Nov 2001 07:51:44 -0500
Date: Fri, 2 Nov 2001 13:51:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Ken Ashcraft <kash@stanford.edu>
cc: <linux-kernel@vger.kernel.org>, <engler@stanford.edu>
Subject: Re: null pointer questions
In-Reply-To: <Pine.GSO.4.33.0111012322470.5198-100000@saga21.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0111021346460.11407-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Nov 2001, Ken Ashcraft wrote:

> 1. If I pass size 0 to kmalloc, what does it return?

AFAIK size is always rounded up, so you get the smallest possible
allocation unit.

> 2. What happens if I pass a null pointer as the destination parameter
> to copy_from_user?  Does copy_from_user handle it safely or will the
> kernel seg fault?

The kernel won't crash, but it might fail (depending on whether 0 is a
valid user space address or not).

bye, Roman


