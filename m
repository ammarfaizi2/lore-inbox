Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSLZDin>; Wed, 25 Dec 2002 22:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLZDin>; Wed, 25 Dec 2002 22:38:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262224AbSLZDim>;
	Wed, 25 Dec 2002 22:38:42 -0500
Date: Wed, 25 Dec 2002 19:45:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dev_printk macro
In-Reply-To: <1040852066.1109.18.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0212251943160.26694-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Dec 2002, Alan Cox wrote:

| On Mon, 2002-12-23 at 00:46, Randy.Dunlap wrote:
| >
| > I'm glad to see this patch available, as Greg was.
| > Now I have some questions about it.
| >
| > a.  Is it only for drivers?  If so, why?
| >     Filesystems and other subsystems that are not drivers could use
| >     something like this also.
|
| Definitely - fs_printk, inode_printk etc may all make sense
| >
| > b.  Is it only for drivers that have a device?
| >     What does a driver use for dev_printk() if it doesn't have a <dev>?
| >     However, these do cover the large majority of cases, so that's good.
|
| This case isnt covered. All devices should eventually have a dev right
| 8)

Eventually, but not always.  Anyway, after another day or 2 to
reflect on it, I'll withdraw the comment I made about checking
<dev> for NULL in those macros.  They can/should be context-sensitive.

-- 
~Randy

