Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265690AbUFDMUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbUFDMUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFDMUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:20:37 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:1153 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265690AbUFDMUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:20:36 -0400
Date: Fri, 4 Jun 2004 14:20:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Flavio Stanchina <flavio@stanchina.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040604122027.GA11950@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org> <200405310638.21015.rob@landley.net> <40BBB861.1010002@stanchina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BBB861.1010002@stanchina.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Of course, mounting/fscking any of the filesystems in question would kinda 
> >screw that up too, [...]
> 
> That reminds me of a question I wanted to ask for a long time.
> 
> Why doesn't suspend just remount everything read-only before saving the
> memory image? Would that be impossible in this context? I find it quite
> scary to have my filesystems dirty *and* part of my files saved in the
> memory image.

Try umount / on busy system some day. No, its not possible in this
context.

OTOH swsuspend does sync(), so your filesystems are not in *that*
scary state.

									Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
