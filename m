Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTIEBIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTIEBIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:08:18 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:33499 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261896AbTIEBIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:08:17 -0400
Subject: Re: [PATCH] fix remap of shared read only mappings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Phillips <phillips@arcor.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309041748290.13736-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309041748290.13736-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062724028.23305.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 05 Sep 2003 02:07:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-05 at 01:49, Linus Torvalds wrote:
> What really matters is that mmap() under Linux is 100% coherent, as far as 
> the hardware just allows. We haven't taken the easy way out. We shouldn't 
> start now.

NFS ?

The problem with OpenGFS is that it is a network file system so
implementing "perfect" shared mmap semantics might actually reduce it
from handy to useless. Right now the worst we have to do is mark pages
uncached in some weird shared map cases, with pages being bounced across
firewire its a bit different.

