Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270749AbTHLQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270816AbTHLQU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:20:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:13206 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270749AbTHLQUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:20:55 -0400
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brandon Stewart <rbrandonstewart@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F38FE5B.1030102@yahoo.com>
References: <3F38FE5B.1030102@yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060705037.12532.49.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Aug 2003 17:17:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-12 at 15:48, Brandon Stewart wrote:
> Apparently, there is an issue with glibc on versions less than 2.3.1-15 
> (and maybe others), where it mistakenly treats CPUs as full i686 
> compliant when they only execute a subset of the i686 instructions

VIA C3 has the full set of i686 required instructions. The whole story
is a lot more complex

gcc i686 mode outputs cmov instruction sequences without checking cmov
is present at runtime. So gcc "i686" is actually "i686 and a bit". It
actually doesn't really make sense to do a true i686 mode without cmov
either.

Red Hat's rpm knows about this so I'm suprised the Mandrake one gets it
wrong and installs arch=686 packages without checking for cmov.

