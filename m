Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbUKVSpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUKVSpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbUKVSjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:39:47 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:49642 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262315AbUKVShr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:37:47 -0500
Date: Mon, 22 Nov 2004 10:39:56 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
Message-ID: <20041122183956.GA50325@gaz.sfgoth.com>
References: <20041120143755.E13550@flint.arm.linux.org.uk> <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com> <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org> <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr> <Pine.LNX.4.58.0411211644200.20993@ppc970.osdl.org> <Pine.LNX.4.53.0411221132550.8845@yvahk01.tjqt.qr> <Pine.LNX.4.58.0411220812580.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411220812580.20993@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 22 Nov 2004 10:39:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So having
> 
> 	int max_of_something;
> 	#define MAX_SOMETHING (0,max_of_something)
> 
> is actually a nice way to make sure nobody does anything like
> 
> 	MAX_SOMETHING = new;

When I want to do that I just use:

	#define MAX_SOMETHING (max_of_something + 0)

When gcc accepts an arbitrary algebraic expression as an lvalue I'll be
impressed :-)

-Mitch
