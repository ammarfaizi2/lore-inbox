Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbTIMTZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTIMTZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:25:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55186 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262173AbTIMTZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:25:51 -0400
Date: Sat, 13 Sep 2003 20:25:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Ricardo Bugalho <ricardo.b@zmail.pt>, insecure@mail.od.ua,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030913192539.GE7404@mail.jlokier.co.uk>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309100034.58742.insecure@mail.od.ua> <pan.2003.09.11.11.06.59.523742@zmail.pt> <200309121826.22936.insecure@mail.od.ua> <1063387648.15891.26.camel@ezquiel.nara.homeip.net> <20030912221717.GB11952@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030912221717.GB11952@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> - Why has Alan measured faster kernels with -Os than with -O2?
> 
> Code size *does* matter.

That's not just i-cache pressure.  It is partly a GCC problem, and
it's possible -Os would run faster than -O2 even with no i-cache.

I've observed -Os emitting exactly the same code as -O2 for some
trivial functions, except that -O2 has a few extra redundant
instructions.

Obvious the _intent_ of -O2 is to compile for speed, but it's clear
that GCC often emits trivially redundant instructions (like stack
adjustments) that don't serve to speed up the program at all.

-- Jamie
