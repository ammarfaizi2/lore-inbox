Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSLYPZu>; Wed, 25 Dec 2002 10:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSLYPZu>; Wed, 25 Dec 2002 10:25:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:41996 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262215AbSLYPZu>;
	Wed, 25 Dec 2002 10:25:50 -0500
Date: Wed, 25 Dec 2002 16:33:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dhirendra Pal Singh <list@actiswitch.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem in EXPORT_SYMBOL.. Please Help!
Message-ID: <20021225153358.GA974@mars.ravnborg.org>
Mail-Followup-To: Dhirendra Pal Singh <list@actiswitch.com>,
	linux-kernel@vger.kernel.org
References: <3E088959.60000@actiswitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E088959.60000@actiswitch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 08:20:41AM -0800, Dhirendra Pal Singh wrote:
> Hi All
[Problem with exported symbol]

Kai G. posted this receipt the other day:
------------
Well, you can do

cd my_module
echo "obj-m := my_module.o" > Makefile
vi my_module.c
make -C <path/to/kernel/src> SUBDIRS=$PWD modules

That's not too bad (and basically works for 2.4 as well)
------------

That should catch any compiletime problems. Just stick in:
echo "export-objs := my_module.o" >> Makefile
To mark it a module with exported symbols.

And for 2.4 you need to include Rules.make:
echo "include path/to/Rules.make"

HTH,
	Sam
