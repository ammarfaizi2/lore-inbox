Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264718AbRFUDLZ>; Wed, 20 Jun 2001 23:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbRFUDLP>; Wed, 20 Jun 2001 23:11:15 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55311 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S264718AbRFUDLE>; Wed, 20 Jun 2001 23:11:04 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Maciek Nowacki <maciek@Voyager.powersurfr.com>
cc: Tom Diehl <tdiehl@pil.net>, linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another? 
In-Reply-To: Your message of "Wed, 20 Jun 2001 14:11:20 CST."
             <20010620141119.A5660@wintermute.starfire> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Jun 2001 13:10:40 +1000
Message-ID: <6827.993093040@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001 14:11:20 -0600, 
Maciek Nowacki <maciek@Voyager.powersurfr.com> wrote:
>Change MODLIB in $(TOPDIR)/Makefile (e.g. /usr/src/linux/Makefile). I do this
>to compile the kernel and modules without root priviledges at all. make
>modules_install will fail at the end when trying to run 'depmod', but that's
>okay - you can do that yourself:

That is not OK, it requires user hacks and causes errors.  Use
  make INSTALL_MOD_PATH=foo modules_install
and everything works.  Create $(INSTALL_MOD_PATH)/lib/modules first.

