Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVD1QBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVD1QBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVD1QBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:01:46 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:3997 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262118AbVD1QB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:01:27 -0400
Date: Thu, 28 Apr 2005 18:01:38 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
cc: fedora-list@redhat.com
Subject: [QLA2300] Call Trace: sleeping function called from invalid context
Message-ID: <Pine.BSO.4.62.0504281742290.10166@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1085698119-1114704033=:10166"
Content-ID: <Pine.BSO.4.62.0504281800490.10166@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1085698119-1114704033=:10166
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0504281800491.10166@rudy.mif.pg.gda.pl>


Configuration:
Sun v20z directly connected to Sun 3511 FC array. HBA:
03:01.0 Fibre Channel: QLogic Corp. QLA2300 64-bit Fibre Channel Adapter (rev 01)

On begining on FC port aren't avalaible any luns for this host.
Change on array controler configuration for map SCSI channel to port 
connected to this host causes on this computer:

qla2300 0000:03:01.0: LIP reset occured (f8f7).
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace: <IRQ> <ffffffff80277156>{device_for_each_child+54}
        <ffffffff880317c5>{:scsi_transport_fc:fc_remote_port_block+53}
        <ffffffff8803c284>{:qla2xxx:qla2x00_mark_all_devices_lost+68}
        <ffffffff8804570f>{:qla2xxx:qla2x00_async_event+2127}
        <ffffffff88045f30>{:qla2xxx:qla2300_intr_handler+384}
        <ffffffff8016135c>{handle_IRQ_event+44} <ffffffff8016148d>{__do_IRQ+253}
        <ffffffff80111678>{do_IRQ+72} <ffffffff8010f027>{ret_from_intr+0}
         <EOI> <ffffffff8010d390>{default_idle+0} <ffffffff8010d3b2>{default_idle+34}
        <ffffffff8010d407>{cpu_idle+71} <ffffffff8050685a>{start_kernel+474}
        <ffffffff80506266>{_sinittext+614}
qla2300 0000:03:01.0: LIP occured (f7f7).

System it is Fedora devel version (2.6.11-1.1275_FC4smp).

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1085698119-1114704033=:10166--
