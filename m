Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271296AbTGRIUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 04:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTGRIUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 04:20:12 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:65460 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S271296AbTGRIUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 04:20:09 -0400
Date: Fri, 18 Jul 2003 10:34:58 +0200
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: 2.6.0-test1 gets corrupted data when loading init
Message-ID: <20030718083458.GC5964@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19dQhe-0002SR-00*OXAeLmoGgh2*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with 2.6.0-test1 I get error like unresolved symbol in libs used by init or
bad elf-file. Sometimes init manages to start and there are same type of
errors in bash when it tries to run initscripts. This is on a dual xeon, no
highmem (512M), ServerWorks chipset, aic79xx scsi, / on scsi.

It breaks between 2.5.70 and 2.5.70-bk1, which contains a update in the
aic79xx-drivers, so my guess is related to that.

Scsi-related hardware in machine:

scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or 66Mhz, 512 SCBs

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI 33 or 66Mhz, 512 SCBs

(scsi1:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
  Vendor: SEAGATE   Model: ST373307LW        Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 03
    

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
