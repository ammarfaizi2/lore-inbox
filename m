Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTHTLti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTHTLth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:49:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:28372 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261921AbTHTLtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:49:36 -0400
Date: Wed, 20 Aug 2003 12:48:49 +0100
From: Dave Jones <davej@redhat.com>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: No rule to make target `drivers/char/agp/isoch.s'
Message-ID: <20030820114849.GA27341@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tuukka Toivonen <tuukkat@ee.oulu.fi>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.55.0308201312130.6320@stekt37>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.55.0308201312130.6320@stekt37>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 01:24:12PM +0300, Tuukka Toivonen wrote:
 > I get the following error when doing "make modules" with kernel
 > 2.6.0-test3 (config file below):
 > 
 >   CC [M]  drivers/char/agp/generic.o
 > make[3]: *** No rule to make target `drivers/char/agp/isoch.s', needed by
 > `drivers/char/agp/isoch.o'.  Stop.
 > make[2]: *** [drivers/char/agp] Error 2
 > make[1]: *** [drivers/char] Error 2
 > make: *** [drivers] Error 2
 > 
 > The problem appears to be missing isoch.c file. However, only one function
 > is referenced in that file, agp_3_5_enable(), and by commenting that call
 > away and removing isoch.o from makefiles, everything works fine in my setup
 > (but it's only a workaround, I guess). It seems 2.6.0-test2 actually has
 > the file.

isoch.c is there in my tree, and Linus'. If you checked this out of
bitkeeper, you may need to bk -r get -S
If not, I've no idea what happened, but I think the problem is at
your end, or a lot more people would've seen this problem.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
