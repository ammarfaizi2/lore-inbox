Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUHKPH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUHKPH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 11:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHKPH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 11:07:57 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:4017 "EHLO
	cpmx.mail.saic.com") by vger.kernel.org with ESMTP id S268077AbUHKPHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 11:07:55 -0400
Subject: slow Gigabit over sk98lin - interrupt handling?
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 11 Aug 2004 16:07:37 +0100
Message-Id: <1092236857.20738.11.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having an ongoing issue getting decent throughput over a gigabit lan
using a 3c2000 gigabit adapter under 2.6.7

Basically, when I attempt to read from the box using ftp, samba,
whatever the bandwidth starts reasonable ( ~12-15 MB/sec using a 1500
MTU ), but quickly drops back to ~3MB/s. While it's transferring,
however, if I open another connection to the server using any host and
initiate another transfer, the bandwidth shoots back up to ~12-15 MB/sec
again for the duration of the multiple connections.

This smacks of interrupt handling, however the box isn't overloaded and
I've tried both enabling interrupt moderation and booting with the lapic
disabled, so only the original XT-PIC is used.

Has anybody got any suggestions for debugging this, as it's rather
frustrating ...

Cheers,
Eamonn

