Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264712AbRFUCmz>; Wed, 20 Jun 2001 22:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264083AbRFUCmp>; Wed, 20 Jun 2001 22:42:45 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:26951 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S264712AbRFUCmh>; Wed, 20 Jun 2001 22:42:37 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: "McHarry, John" <john.mcharry@gemplex.com>, linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another? 
In-Reply-To: Your message of "Wed, 20 Jun 2001 09:58:54 +0200."
             <3B3057BE.4374D4B2@idb.hist.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Jun 2001 12:42:17 +1000
Message-ID: <6519.993091337@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001 09:58:54 +0200, 
Helge Hafting <helgehaf@idb.hist.no> wrote:
>This is enough if you don't use modules.  If you use modules you
>need to copy them too, which is trickier.  Several good methods
>have been demonstrated, here is another if you can't use the nfs
>approach:
>
>1. If you are running the same kernel revision on the compile machine,
>   temporarily rename /lib/modules/<version> to something else.
>   Yes - this could be dangerous but tend to work well on a "home
>machine"
>2. Do the "make modules_install" on the compile machine.

The correct way of installing for a target machine is to use
  make INSTALL_MOD_PATH=foo modules_install
You need to mkdir -p foo/lib/modules first.  Everything is installed in
foo/lib/modules/`uname -r` instead of /lib/modules so you do not
disturb your compile system.

There is also make INSTALL_PATH to specify where vmlinuz and System.map
are stored for make zlilo and make install.

