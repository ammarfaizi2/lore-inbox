Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBCHux>; Sat, 3 Feb 2001 02:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129035AbRBCHun>; Sat, 3 Feb 2001 02:50:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33546 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129033AbRBCHuf>; Sat, 3 Feb 2001 02:50:35 -0500
Subject: Re: bidirectional named pipe?
To: Brendan.Miller@Dialogic.com (Miller, Brendan)
Date: Sat, 3 Feb 2001 07:51:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <EFC879D09684D211B9C20060972035B1D4684F@exchange2ca.sv.dialogic.com> from "Miller, Brendan" at Feb 02, 2001 07:33:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OxTz-0007yS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm porting some software to Linux that requires use of a bidirectional,
> named pipe.  The architecture is as follows:  A server creates a named pipe

Pipes are not bidirectional in Linux. We follow traditional non stream
behaviour

> /dev/spx".  I experiemented with socket-based pipes under Linux, but I
> couldn't gain access to them by open()ing the name.  Is there help?  I

AF_UNIX sockets are bidirectional but like all sockets use bind() and
connect().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
