Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTJ0IaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 03:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbTJ0IaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 03:30:25 -0500
Received: from main.gmane.org ([80.91.224.249]:64676 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261336AbTJ0IaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 03:30:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: Re: [2.6 patch] give SATA its' own menu
Date: Mon, 27 Oct 2003 09:30:20 +0100
Message-ID: <bnil2s$3ba$1@sea.gmane.org>
References: <20031026001554.GC23291@fs.tum.de> <20031026011145.GB23690@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Will users know that they have to enable SCSI disk & cdrom support to get
> it really to work?
> Petr

It will select SCSI automatically, see the "select SCSI" line.

>  
>> +config SCSI_SATA
>> +    bool "Serial ATA (SATA) support"
>> +    depends on EXPERIMENTAL
>> +    select SCSI
>> +    help
>> +      This driver family supports Serial ATA host controllers
>> +      and devices.
>> +
>> +      If unsure, say N.



If you don't want to select something automatically, you could do it with a
comment-to-the-user:

comment "Serial ATA needs SCSI support"
  depends on !(SCSI && EXPERIMENTAL)
config SCSI_SATA
  bool "Serial ATA (SATA) support"
  depends on SCSI && EXPERIMENTAL


-- 
Try Linux 2.6 from BitKeeper for PXA2x0 CPUs at
http://www.mn-logistik.de/unsupported/linux-2.6/

