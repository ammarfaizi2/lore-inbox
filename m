Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVANLbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVANLbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 06:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVANLbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 06:31:24 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:56508 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261956AbVANLbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 06:31:20 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Help interpreting Machine Check Exception
Date: Fri, 14 Jan 2005 11:31:13 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501141131.13053.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a dual opteron numa machine and I am seeing messages like this during 
boot:

CPU 0: Machine Check Exception:               4 Bank 4: b200000000070f0f
TSC b961d94950
kernel panic - not syncing: Machine check

Which when run through Dave Jones tool says

andrew@orac test $ ./a.out -b 4 -s b200000000070f0f -e 4 -a 0
Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(4): b200000000070f0f @ 0
        External tag parity error
        CPU state corrupt. Restart not possible
        Error enabled in control register
        Error not corrected.
        Bus and interconnect error
        Participation: Generic
        Timeout:
        Request: Generic error
        Transaction type : Invalid
        Memory/IO : Other


Any clues on what might be broken? does "Bus and interconnect error" suggest 
the MB?

I have reseating all memory and cpus, and run memtest overnight without error.

Andrew Walrond
