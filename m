Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290736AbSARQmW>; Fri, 18 Jan 2002 11:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290737AbSARQmL>; Fri, 18 Jan 2002 11:42:11 -0500
Received: from air-1.osdl.org ([65.201.151.5]:2576 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S290736AbSARQl5>;
	Fri, 18 Jan 2002 11:41:57 -0500
Date: Fri, 18 Jan 2002 08:39:26 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Roger W.Brown" <bregor@anusf.anu.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Type-change of kdev_t
In-Reply-To: <20020118134245.630F6706B1@argo.anu.edu.au>
Message-ID: <Pine.LNX.4.33L2.0201180836550.13155-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2002, Roger W.Brown wrote:

|
|   Hi,
|
|       I'm no kernel hacker so I am little hesitant to speak; however,
|   I'm looking at kdev_t.h from the linux-2.5.3-pre1 source.
|
|   The type of kdev_t has changed recently from a scalar type to a
|   structured type.  Should macro definitions such as MINOR(dev) also
|   be revised to be consistent with the "new" kdev_t ?

Macros to use kdev_t also changed.

|   Something like:
|
|   #define MINOR(dev)  ((unsigned int) ((dev.value) & MINORMASK))
|
|   rather than
|
|   #define MINOR(dev)  ((unsigned int) ((dev) & MINORMASK))
|
|   Then usage of the MINOR() macro remains unchanged.

Nope, use major() and minor() instead [although I prefer
the kmajor() and kminor() patch].

See http://www.osdl.org/archive/rddunlap/linux-port-25x.html,
item 7, bullet 3, which points to an email from one Linus Torvalds
about the kdev_t change.

-- 
~Randy

