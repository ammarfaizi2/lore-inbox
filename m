Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWACOtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWACOtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWACOtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:49:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:16139 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932390AbWACOts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:49:48 -0500
Date: Tue, 3 Jan 2006 15:49:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 17/26] kbuild: Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20060103144940.GB18012@mars.ravnborg.org>
References: <11362947262643@foobar.com> <Pine.LNX.4.61.0601031546100.436@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601031546100.436@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 03:46:26PM +0100, Jan Engelhardt wrote:
> >This is a one-line change to parse.y.
> >To take advantage of this the scripts/genksyms/*_shipped files needs to
> >be rebuild - this is the next patch.
> >
> >When a .c file contains:
> >DEFINE_PER_CPU(struct foo_s *, bar);
> >
> >the .cpp output looks like:
>      ^^^^
> 
> Are you right about C++?

It's the pre-processed output with DEFINE_PER_CPU expanded, not C++.

	Sam
