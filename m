Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTCBV3t>; Sun, 2 Mar 2003 16:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTCBV3t>; Sun, 2 Mar 2003 16:29:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:23821 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261173AbTCBV3t>;
	Sun, 2 Mar 2003 16:29:49 -0500
Date: Sun, 2 Mar 2003 22:40:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: fix make -j4 on UP
Message-ID: <20030302214013.GA13138@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030302201648.GA14770@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302201648.GA14770@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 09:16:48PM +0100, Sam Ravnborg wrote:
> The following patch moves the generation of compile.h to the
> top-level makefile, and list it in the prepare rule.

Which has the side-effect that compile.h will be generated each time,
because the version increases. And the kernel is recompiled.
I will do a proper fix tomorrow.

	Sam
