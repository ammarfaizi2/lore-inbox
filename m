Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTLEXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbTLEXsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:48:08 -0500
Received: from SMTP2.andrew.cmu.edu ([128.2.10.82]:7136 "EHLO
	smtp2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S264830AbTLEXsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:48:06 -0500
Date: Fri, 5 Dec 2003 18:48:06 -0500 (EST)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: BusLogic scsi crash.
Message-ID: <Pine.LNX.4.58-035.0312051843460.7457@unix50.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I get
"kernel panic: scsi_free: Bad offset
In interrupt handler: not syncing"
and a deadlock with a 2.4.23 kernel on a SMP (Dual Pentium II) machine.
I'm using a BusLogic card and the only communication on the SCSI bus is
to a CD jukebox with one CD mounted (crash observed with many, too, but
X was running at the time so I don't know if the message was different).

About thirty seconds before crashing the SCSI bus attemted a reset
(apparently successfully, though no more data flow was observed).  During
this reset the system was utterly unresponsive for two seconds before
resuming seemingly normal operations - this same two second lag is
observed at module load (BusLogic) time.

What more information would be useful to fixing this problem?

Thanks.
--nwf;
