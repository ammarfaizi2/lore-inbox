Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271377AbTG2Jmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271359AbTG2JkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:40:13 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:20645 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S271351AbTG2Jb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:31:26 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [BUG 2.6.0test2] unwanted ATAPI requests during boot
From: <ffrederick@prov-liege.be>
Date: Tue, 29 Jul 2003 11:57:56 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S271351AbTG2Jb0/20030729094000Z+349@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
        2.6.0.test2 does the following when no cd inserted during boot:
2.6.0test1mm2 was ok.

        Problem could come from bio changes (ll_rw_blk).When tracing make_request, I've got neverending polling there...

Regards,
Fabian

hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
end_request: I/O error, dev hdc, sector 0
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Start/Stop Unit" packet command was: 
  "1b 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 "
cdrom: open failed.


___________________________________



