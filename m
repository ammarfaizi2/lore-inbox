Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTEUKCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 06:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTEUKCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 06:02:44 -0400
Received: from tiffi.office-b.jamba.net ([194.221.137.169]:39392 "EHLO
	tiffi.office-b.jamba.net") by vger.kernel.org with ESMTP
	id S262011AbTEUKCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 06:02:42 -0400
Message-ID: <3ECB51C6.30309@jamba.net>
Date: Wed, 21 May 2003 12:15:34 +0200
From: Andreas Heilwagen <andreas.heilwagen@jamba.net>
Organization: Jamba! AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: stefan.altenkamp@jamba.net
Subject: 2.5.66 kernel panic: fs/xfs/pagebuf/page_buf..c
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am in the unfortunate position to run a production server with 2.5.66 
since the SuperMicro CSE-742S-500 has no suitable APIC support in the 
2.4.x series. Why I do not run 2.5.69? The machine panics twice a day.

2.5.66 dies once a day with "kernel panic: Aiee, killing interrupt 
handler" in fs/xfs/pagebuf/page_buf.c:1287. The reason is an "invalid 
operand:0000 #5" on CPU:0 with "EIP:0060:[<c024f059>] Not tainted". In 
my case slapd from the OpenLDAP package caused the crash.

I have an 39320 Dual U320 SCSI controller in the machine with a Overland 
PowerLoader LTO-1 (17 slots) and a Infortrend IFT 6300-12 IDE-Raid with 
one 700G XFS volume configured.

Currently I am not able to backup the machine using Arkeia 5.1.7 without 
running one backup process on the local machine in a long-term disk 
sleep or getting a panic.

I'd like to get in touch with an person actively working on the XFS or 
APIC stuff to discuss how I can contribute to stabilize the APIC code 
for the Supermicro board and how to analyze/fix the XFS problem. I dot 
not want to file Bugzilla entries at this time before I cannot be sure 
that I missed an obvious solution.


Looking forward,

Andreas Heilwagen

