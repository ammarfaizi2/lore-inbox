Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWHPTPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWHPTPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWHPTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:15:43 -0400
Received: from xenotime.net ([66.160.160.81]:9600 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750906AbWHPTPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:15:42 -0400
Date: Wed, 16 Aug 2006 12:15:37 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: nick@linicks.net
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix crash case
In-Reply-To: <7c3341450608161210ua4d0d4esc54f98c3ada69f3d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0608161214380.30053@shark.he.net>
References: <1155746131.24077.363.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0608161938320.20450@yvahk01.tjqt.qr>
 <7c3341450608161210ua4d0d4esc54f98c3ada69f3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Nick Warne wrote:

> Sorry for being a noob here - I read LKML to try to learn.
>
> What is meant by 'If we are going to BUG()...  cover the case
> of the BUG being compiled out'.
>
> What would make BUG(); not being compiled?

It's a config option is EMBEDDED=y:

config BUG
	bool "BUG() support" if EMBEDDED
	default y
	help
          Disabling this option eliminates support for BUG and WARN, reducing
          the size of your kernel image and potentially quietly ignoring
          numerous fatal conditions. You should only consider disabling this
          option for embedded systems with no facilities for reporting errors.
          Just say Y.

-- 
~Randy
