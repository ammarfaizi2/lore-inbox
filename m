Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbTGKVon (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbTGKVon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:44:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55736
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266499AbTGKVom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:44:42 -0400
Subject: Re: PATCH: switch maestro3 to new ac97
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030711184822.GE16037@gtf.org>
References: <200307111815.h6BIFQET017362@hraefn.swansea.linux.org.uk>
	 <20030711184822.GE16037@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057960602.20629.54.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 22:56:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 19:48, Jeff Garzik wrote:
> I note another positive attribute as well:
> 
> This new AC97 stuff makes object lifetime much more obvious, and makes
> it easy for someone to add refcounting later, if that comes up.
> 
> This patch is an excellent example of such.

Thats actually intentional. The current stuff doesn't need the
ref counting because it uses the coded locks for unload v I/O
locking, but people are adding a lot of stuff to ac97 now.

AC97 is DAC/ADC and GPIO pins, hence its showing up used for battery
reporting, touchscreens and other goodies.

