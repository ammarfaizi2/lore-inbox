Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTAVFda>; Wed, 22 Jan 2003 00:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267378AbTAVFda>; Wed, 22 Jan 2003 00:33:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4107 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267377AbTAVFd3>;
	Wed, 22 Jan 2003 00:33:29 -0500
Date: Wed, 22 Jan 2003 06:42:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Miles Bader <miles@gnu.org>
Cc: Greg Ungerer <gerg@snapgear.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
Message-ID: <20030122054230.GA954@mars.ravnborg.org>
Mail-Followup-To: Miles Bader <miles@gnu.org>,
	Greg Ungerer <gerg@snapgear.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301212045000.1577-100000@chaos.physics.uiowa.edu> <3E2E0F38.7090506@snapgear.com> <buoptqp954l.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoptqp954l.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 01:32:10PM +0900, Miles Bader wrote:
> 
> [To be honest, I think the stuff with `LOAD_OFFSET' is a bit of a waste;
> it seems cleaner to just have archs define their own sections as
> appropriate, and use RODATA_CONTENTS directly -- it's the input sections
> and related symbols that are always changing (and so better centralized),
> after all, not the output sections.]

There were some reports of failed boots that boiled down to
mis-alignment of a single section.
With your suggestion we will end up in the same problem.
__start_ksymbtab will in some cases have a value less than the actual
start of the first symbol.

	Sam
