Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752428AbWCFVJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbWCFVJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbWCFVJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:09:26 -0500
Received: from mxout1.netvision.net.il ([194.90.9.20]:17701 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S1752427AbWCFVJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:09:26 -0500
Date: Mon, 06 Mar 2006 23:09:51 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re: Re: problems with scsi_transport_fc and qla2xxx
In-reply-to: <170fa0d20603061200y38315a62uf143258c79659381@mail.gmail.com>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <1119462161.20060306230951@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <1413265398.20060227150526@netvision.net.il>
 <978150825.20060227210552@netvision.net.il>
 <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at>
 <20060301210802.GA7288@spe2> <957728045.20060302193248@netvision.net.il>
 <170fa0d20603061200y38315a62uf143258c79659381@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike!
Unfortunately I don't have the directory /proc/scsi/qla2xxx.
However the target sees PRLI from the host again after reconnecting
the cable between the initiator and the switch.
Does it mean the rediscovering new devices on initiator side is
already done?

Thanks,

Maxim.

MS> Historically the qlogic driver rescan is a 2-phase process:
MS> 1) schedule the rescan, e.g.: echo scsi-qlascan > /proc/scsi/qla2xxx/4
MS> 2) rescan, e.g.: echo - - - > /sys/class/scsi_host/host4/scan

MS> BUT, I've just used scsi-qlascan to discover _new_ devices... not
MS> existing devices that experienced FC connection loss.  I assume the
MS> qla driver _should_ just bring those lost devices back?  But does the
MS> historic 2-phase rescan for new devices speak to why the qlogic driver
MS> doesn't automagically bring the old devices back?  Or has the latest
MS> qlogic driver in mainline advanced past this 2-phase requirement in
MS> general?

MS> regards,
MS> Mike

MS> Mike


