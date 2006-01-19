Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161430AbWASU5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161430AbWASU5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWASU5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:57:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:59909 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422644AbWASU5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:57:31 -0500
Date: Thu, 19 Jan 2006 21:56:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kconfig: fix /dev/null breakage
Message-ID: <20060119205603.GA3919@mars.ravnborg.org>
References: <20060119200216.GA3557@mars.ravnborg.org> <20060119200418.GB3557@mars.ravnborg.org> <Pine.LNX.4.61.0601192128141.26558@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601192128141.26558@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 09:28:48PM +0100, Jan Engelhardt wrote:
> 
> >Following patch implements a suggestion
> >from Bryan O'Sullivan <bos@serpentine.com> to
> >use gcc -print-file-name=libxxx.so.
> 
> Just for completeness: Does it work with all gccs supported?

It has been used like this:
NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)

for a few months in the main Makefile.
So I assume yes.

	Sam
