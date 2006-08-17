Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWHQHqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWHQHqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHQHqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:46:12 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:53388 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932146AbWHQHqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:46:11 -0400
Date: Thu, 17 Aug 2006 09:45:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: clowncoder <clowncoder@clowncode.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New version of ClownToolKit
In-Reply-To: <20060816184803.GD5852@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0608170944240.16217@yvahk01.tjqt.qr>
References: <1155749588.3839.19.camel@localhost.localdomain>
 <20060816184803.GD5852@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The kernel module of the last version of the ClownToolKit has been 
>> completly rewriten. It is now readable. 
>> This kernel module permits the display of real-time plots for 
>> bandwidth of tcp/udp connexions and for qdiscs monitoring. 
>> It could be a usefull tool: http://clowncode.net 
>
>A small nitpick about the way ou build the ekrnel module:
>
>In mk_and_insmod you can replace:
>make -C /usr/src/linux SUBDIRS=$PWD modules
>with
>LIBDIR=/lib/modules/`uname -r`
>make -C $LIBDIR/source O=$LIBDIR/build SUBDIRS=`pwd` modules

Might like to replace with
make -C $LIBDIR/build M=`pwd` modules

>$PWD is supplied by the shell, so it is better to use `pwd`.

Does not harm really.


Jan Engelhardt
-- 
