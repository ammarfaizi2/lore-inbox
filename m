Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136020AbREGGsq>; Mon, 7 May 2001 02:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136024AbREGGs0>; Mon, 7 May 2001 02:48:26 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:41587 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S136020AbREGGsV>; Mon, 7 May 2001 02:48:21 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Maciek Nowacki <maciek@Voyager.powersurfr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: scripts/Configure patch for automatic module compile 
In-Reply-To: Your message of "Mon, 07 May 2001 00:34:13 CST."
             <20010507003413.A28246@megabyte> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 May 2001 16:48:02 +1000
Message-ID: <11351.989218082@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001 00:34:13 -0600, 
Maciek Nowacki <maciek@Voyager.powersurfr.com> wrote:
>If you're like me, you build everything as modules, boot with an initrd that
>loads in the disk or net driver and filesystem module, and then let kmod take
>care of the rest. Here's a patch that changes Configure (make config) to
>build all possible modules - in other words, to answer 'M' for every tristate
>of some form y/m/n.

I already have a patch from Ghozlane Toumi in my inbox that supports:

make randconfig
  answers randomly to the questions .

make allyes
  answers 'yes' to all questions .

make allno
  answers 'no' to all questions .

make allmod
  answer 'm' if avaiable, 'yes' else .

Plus you can specify defaults in .force_default which will always be
honoured.  I have been using it to stress test the 2.4.4 configs and my
2.5 makefile rewrite, it works very nicely.

