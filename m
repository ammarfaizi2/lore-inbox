Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbTAGROk>; Tue, 7 Jan 2003 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTAGROj>; Tue, 7 Jan 2003 12:14:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51985 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267454AbTAGROe>;
	Tue, 7 Jan 2003 12:14:34 -0500
Date: Tue, 7 Jan 2003 18:23:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Michal Sojka <sojka@planetarium.cz>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: Insmod failed
Message-ID: <20030107172308.GA1472@mars.ravnborg.org>
Mail-Followup-To: Michal Sojka <sojka@planetarium.cz>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <3E1B0985.6050100@planetarium.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1B0985.6050100@planetarium.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 06:08:21PM +0100, Michal Sojka wrote:
> Hi,
> 
> I'am porting driver for my USB 2.0 device to 2.5 and when I try insmod 
> my module I get the following:
> 
> Error inserting '/lib/modules/2.5.54/misc/usb-emise.o': -1 Invalid 
> module format
> 
> 
> I compile my module separate of kernel tree with Makefile similar to 
> that in Linux Device Drivers book (Rubini, Corbet). What is the right 
> way to compile standalone modules?

Kai posted the following a few weeks ago:
-----
Well, you can do

cd my_module
echo "obj-m := my_module.o" > Makefile
vi my_module.c
make -C <path/to/kernel/src> SUBDIRS=$PWD modules
-----

Let me know if this solves the problem,

	Sam
