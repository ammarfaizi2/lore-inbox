Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTESVqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTESVqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:46:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:40199 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263150AbTESVqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:46:19 -0400
Date: Mon, 19 May 2003 23:59:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] pull $CROSS_COMPILE from env. if present
Message-ID: <20030519215917.GA1281@mars.ravnborg.org>
Mail-Followup-To: torvalds@transmeta.com,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030519195333.GC18426@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519195333.GC18426@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:53:33PM -0700, Jesse Barnes wrote:
> Simple patch to pull CROSS_COMPILE from the environment if it's
> present, which makes it easier to compile the kernel with different
> compiler versions and such.

I like it, but...

If we do it for CROSS_COMPILE we should do it for ARCH as well.
Something like
ifeq ($(origin ARCH), undefined)
ARCH := $(SUBARCH)
endif

And then group ARCH and CROSS_COMPILE togeher in the Makefile, and
provide a few meaningful comments.
I will test it tomorrow if you do not beat me in it.

	Sam
