Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbRLWAKW>; Sat, 22 Dec 2001 19:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283003AbRLWAKN>; Sat, 22 Dec 2001 19:10:13 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:26116 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S283002AbRLWAKE>; Sat, 22 Dec 2001 19:10:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: otto.wyss@bluewin.ch,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 19:08:46 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C1D060B.9475C9F8@bluewin.ch>
In-Reply-To: <3C1D060B.9475C9F8@bluewin.ch>
Cc: Rusty Russell <rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16HwC0-0001k4-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 December 2001 15:37, Otto Wyss wrote:

> modules) are combined into a single file. The boot loader (i.e. lilo)

LILO follows an outdated, broken concept and should once and for all
be layed to rest, preferably with a stake through it's heart. 

> simply loads this file and starts the first stream (the kernel).

The point to all these 'streams' escapes me. The proper way to implement
this has all ready been done. It's called the Multi Boot Standard
as implemented in GRUB bootloader. http://www.gnu.org/software/grub/

GRUB is similar to syslinux in that is can read directly from the the FS,
but unlike syslinux supports just about all of them instead of just FAT.

Basically what Grub does is loads the kernel modules from disk
into memory, and 'tells' the kernel the memory location to load
them from, very similar to how an initrd file is loaded. The problem
is Linux, is not MBS compilant and doesn't know to look for and load
the modules. 

HOWEVER I recieved patches from
	"ChristianK."@t-online.de (Christian Koenig)
last week that actually implments the module loading in Linux!
I'm trying to get Rusty interested in them, but thus far have not
heard back from him. (Hey Paul! Hit that reply button!)

Anyone interested mail me off list to go over this in more detail.

Dave

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
