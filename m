Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTI2RO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTI2RNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:13:09 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9861 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263839AbTI2RLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:11:25 -0400
Date: Mon, 29 Sep 2003 18:11:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Valdis.Kletnieks@vt.edu
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Message-ID: <20030929171113.GD21798@mail.jlokier.co.uk>
References: <20030929090629.GF29313@actcom.co.il> <20030929153437.GB21798@mail.jlokier.co.uk> <200309291551.h8TFpZtH028192@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309291551.h8TFpZtH028192@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> Is this supposed to return the bitmask bit2, or (x & bit2)?  If the former,
> then your code is right.  If the latter,  (x & bit1) ? (x & bit2) : 0

The former.

> I'm totally failing to see why the original did the bit1 == bit2 compare,
> so maybe mhyself and Jamie are both missing some subtlety?

"bit1 == bit2" was an optimisation.  It made the machine code smaller,
without changing the result.

-- Jamie
