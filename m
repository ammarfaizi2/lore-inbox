Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSHJAjI>; Fri, 9 Aug 2002 20:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHJAjI>; Fri, 9 Aug 2002 20:39:08 -0400
Received: from sutr.cynic.org ([64.174.133.194]:42439 "EHLO sutr.cynic.org")
	by vger.kernel.org with ESMTP id <S316390AbSHJAjI>;
	Fri, 9 Aug 2002 20:39:08 -0400
Date: Fri, 09 Aug 2002 17:42:30 -0700
From: Perry The Cynic <perry@cynic.org>
To: tony@atomide.com, thetech@folkwolf.net
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: amd76x_pm hard hang with 2.4.19-ac4
Message-ID: <86796134.1028914950@loki.cynic.org>
X-Mailer: Mulberry/2.2.1 (Mac OS X)
Organization: Cynics at Large
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying out the amd76x_pm driver with 2.4.19-ac4 on a Tyan Thunder K7X 
(S2468UGN) produces hard hangs under load. The system looks okay when idle, 
but heavy Disk I/O (onboard SCSI, basically tar cfz) produces the hang 
within a few minutes. (No hangs unless the amd76x_pm module is loaded.)

The board is otherwise quite stable (i.e. no unexplained 
hangs/crashes/panics).

Any suggestions on how to approach this? The C2 idle loop code is what 
changed for me (from 2.4.19pre10-ac2). But I don't know enough about ACPI 
to know where to start... what info would help?

Oh, and this driver (while it works) shaves a full 140W off the power 
consumption. Cool.

Thanks
  -- perry
---------------------------------------------------------------------------
Perry The Cynic                                             perry@cynic.org
To a blind optimist, an optimistic realist must seem like an Accursed Cynic.
---------------------------------------------------------------------------

