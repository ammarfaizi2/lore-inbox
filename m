Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSFXWAf>; Mon, 24 Jun 2002 18:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSFXWAe>; Mon, 24 Jun 2002 18:00:34 -0400
Received: from perplex.selfdestruct.net ([195.197.225.4]:13471 "EHLO
	perplex.selfdestruct.net") by vger.kernel.org with ESMTP
	id <S315358AbSFXWA1>; Mon, 24 Jun 2002 18:00:27 -0400
Date: Tue, 25 Jun 2002 00:56:19 +0300
From: Toni Viemero <toni.viemero@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Another .text.exit error with 2.4.19-rc1
Message-ID: <20020624215619.GE27147@perplex.selfdestruct.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like ServeRAID driver is causing problems

System: Debian GNU/Linux unstable (IBM eServer 232 with ServeRAID 4Lx)

compiling kernel stops, error output:

drivers/scsi/scsidrv.o(.data+0x3874): undefined reference to local symbols
in discarded section .text.exit'


and output of "reference_discarded.pl" by Keith Owens:

aq144:/usr/src/linux# perl ../reference_discarded.pl 
Finding objects, 392 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 35 conglomerate(s)
Scanning objects
Error: ./drivers/scsi/ips.o .data refers to 000000d4 R_386_32
.text.exit
Done

Regards,
-- 
Toni Viemerö  |  http://selfdestruct.net
"The ones who dont do anything are always the ones who try to pull you
 down."
