Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUAaWlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 17:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAaWlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 17:41:05 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:59813 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265141AbUAaWlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 17:41:03 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 23:29:19 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131222919.GF2160@kiste>
References: <20040131104606.GA25534@kiste> <Pine.LNX.4.58.0401311052180.2105@home.osdl.org> <20040131200050.GA2160@kiste> <Pine.LNX.4.58.0401311223110.2105@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401311223110.2105@home.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some further information: as I just found out by further mangling bert's
test program, the bug seems to be SMP related.

In other words, the Python program in question runs without any problem
at all if I simply start it as

	taskset 01 mini-dinstall

i.e. everything on a single CPU.

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
