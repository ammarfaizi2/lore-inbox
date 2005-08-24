Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVHXVW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVHXVW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVHXVW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:22:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:49367 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932253AbVHXVWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:22:25 -0400
Subject: Re: [PATCH 00/15] Remove asm/segment.h from low hanging
	architectures
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@freescale.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Aug 2005 22:50:44 +0100
Message-Id: <1124920244.13833.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-24 at 11:43 -0500, Kumar Gala wrote:
> The following set of patches removes the use and existence of 
> asm/segment.h from the architecture ports 

You've broken various things by doing this because some driver code
rightly or wrongly uses segment.h. That is fine because they shouldn't
do so. However asm/segment.h isn't supoosed to be removed on
architectures that use segments- like x86, and x86-64. There it is a
real arch private file and shouldn't be disappearing.

It shouldn't be leaking into drivers any more (eg mxser.c is an offender
there)

