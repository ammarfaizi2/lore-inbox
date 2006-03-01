Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWCAVzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWCAVzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWCAVzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:55:09 -0500
Received: from ozlabs.org ([203.10.76.45]:57778 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751276AbWCAVzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:55:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17414.6192.426294.502401@cargo.ozlabs.ibm.com>
Date: Thu, 2 Mar 2006 08:54:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: linuxppc64-dev@ozlabs.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johnrose@austin.ibm.com
Subject: Re: fix build breakage in eeh.c in 2.6.16-rc5-git5
In-Reply-To: <20060301214600.GA17702@kroah.com>
References: <20060301214600.GA17702@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> This patch should fixe a problem with eeh_add_device_late() not being
> defined in the ppc64 build process, causing the build to break.

John Rose just sent a patch making eeh_add_device_late static and
moving it to be defined before it is called in
arch/powerpc/platforms/pseries/eeh.c.

Since he maintains this stuff, I'm more inclined to take his patch.

Paul.
