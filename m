Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWBUR46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWBUR46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWBUR46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:56:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38162 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932332AbWBUR4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:56:54 -0500
Date: Tue, 21 Feb 2006 18:56:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the CONFIG_CC_ALIGN_* options
Message-ID: <20060221175640.GB9070@mars.ravnborg.org>
References: <20060220223654.GR4661@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220223654.GR4661@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 11:36:54PM +0100, Adrian Bunk wrote:
> I don't see any use case for the CONFIG_CC_ALIGN_* options:
> - they are only available if EMBEDDED
> - people using EMBEDDED will most likely also enable 
>   CC_OPTIMIZE_FOR_SIZE
> - the default for -Os is to disable alignment
> 
> In case someone is doing performance comparisons and discovers that the
> default settings gcc chooses aren't good, the only sane thing is to
> discuss whether it makes sense to change this, not through offering 
> options to change this locally.

I leave it to other to judge if this is wortwhile or not - I have no
numbers to back up either with or without.
It is though a nice cleaning effort in the Makefile.

But if we back-out this then cc-option-aling should go as well,
including description in Documentation/kbuild/makefiles.txt

	Sam
