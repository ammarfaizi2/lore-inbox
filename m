Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTB0TmP>; Thu, 27 Feb 2003 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTB0TmP>; Thu, 27 Feb 2003 14:42:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:28838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266771AbTB0TmM>;
	Thu, 27 Feb 2003 14:42:12 -0500
Date: Thu, 27 Feb 2003 11:47:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-Id: <20030227114752.2f687dcc.rddunlap@osdl.org>
In-Reply-To: <20030227193943.GA28379@actcom.co.il>
References: <39710000.1045757490@[10.10.2.4]>
	<Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
	<20030227105056.3fd76ac6.rddunlap@osdl.org>
	<20030227193943.GA28379@actcom.co.il>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003 21:39:44 +0200
Muli Ben-Yehuda <mulix@mulix.org> wrote:

| On Thu, Feb 27, 2003 at 10:50:56AM -0800, Randy.Dunlap wrote:
| > On Thu, 20 Feb 2003 08:54:55 -0800 (PST)
| > Linus Torvalds <torvalds@transmeta.com> wrote:
| 
| [snipped] 
| 
| > | A sorted list of bad stack users (more than 256 bytes) in my default build
| > | follows. Anybody can create their own with something like
| > | 
| > | 	objdump -d linux/vmlinux |
| > | 		grep 'sub.*$0x...,.*esp' |
| > | 		awk '{ print $9,$1 }' |
| > | 		sort > bigstack
| > | 
| > | and a script to look up the addresses.
| 
| [snipped] 
| 
| > I don't get a nice listing from this script like you did.
| > Example of mine is below.  Do I just have a tools issue?
| 
| See the part where Linus said "...and a script to look up the
| addresses.". You can use 'ksymoops -v vmlinux -m System.map --no-ksyms
| --no-lsmod -A 0xcodebabe' to translate address to symbol. 

Yes, sorry about skimming over that.
And yes, I'm familiar with that option of ksymoops.*  :)

--
~Randy


*: since it's based on
   http://www.osdl.org/archive/rddunlap/scripts/ksysmap
