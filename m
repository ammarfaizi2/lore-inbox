Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbTJFMue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 08:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTJFMue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 08:50:34 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:44468 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S261958AbTJFMud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 08:50:33 -0400
Date: Mon, 6 Oct 2003 14:50:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Dave Jones <davej@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <Pine.LNX.4.53.0310060834180.8593@chaos>
Message-ID: <Pine.GSO.3.96.1031006144540.18687A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Richard B. Johnson wrote:

> I suggest that the FDC control byte be read, then the result be
> ANDed with ~0x10, then written back. The ifed-out code clears
> the whole control word which is inappropriate at a time the
> diskette channel may be still be active.

 Which will work for a physical drive 0x0 only -- it won't work for a
BIOS-emulated drive swapping.  Supposedly the most reliable way should be
ANDing with ~0xf0, or better yet, using a BIOS call, preferably by fixing
the boot loader used. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

