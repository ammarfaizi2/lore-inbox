Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272325AbTHBJGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272355AbTHBJGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:06:06 -0400
Received: from vt.ibt.lt ([193.219.56.32]:59019 "EHLO vt.fermentas.lt")
	by vger.kernel.org with ESMTP id S272325AbTHBJGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:06:04 -0400
From: Vitalis Tiknius <vt@vt.fermentas.lt>
Organization: myself
To: linux-kernel@vger.kernel.org
Subject: 2.6 ide i/o performance
Date: Sat, 2 Aug 2003 12:05:59 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308021205.59280.vt@vt.fermentas.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i simultaneously burned (audio mode, without scsi emulation) and ripped cd's 
under 2.6.0-test2-mm2. devices are:

 ../ide/host0/bus1/target0/lun0/cd (Teac CD-W552E) 
 ../ide/host0/bus1/target1/lun0/cd (Teac DV-516E).

mobo is Intel 875. software is k3b-0.9, cdrtools-2.01_alpha18, grip-3.1.1, and 
cdparanoia-3.9.8 with all paranoia options on.

when burning and ripping are performed separately, their speeds are approx. 
42x and 6.3x. when simultaneously, 12x and 1.6x with no options touched.

although devices are on the same controller (my first controller is SATA) and 
on the same bus, i'd rather expect linear and not almost square-law 
throughput regression observed. are the things expected to go this way, or 
there is some room for optimizations, etc.? 
