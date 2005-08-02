Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVHBGnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVHBGnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVHBGnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:43:05 -0400
Received: from outmx025.isp.belgacom.be ([195.238.2.49]:24783 "EHLO
	outmx025.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261395AbVHBGnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:43:04 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13-rc5 - possible acpi regression?
Date: Tue, 2 Aug 2005 08:43:07 +0200
User-Agent: KMail/1.8.1
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508020843.08030.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 August 2005 07:07, Linus Torvalds wrote:
> Ok, one more in the series towards final 2.6.13.

One thing that seems like a regression: doing

$ cat /proc/acpi/battery/BAT1/info

causes a two-second pause and then gives me the information, while in 2.6.12.3 
that was near-instant.

$ date; cat /proc/acpi/battery/BAT1/info ; date
Tue Aug  2 08:41:03 CEST 2005
present:                 yes
design capacity:         4400 mAh
last full capacity:      418 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 250 mAh
design capacity low:     100 mAh
capacity granularity 1:  10 mAh
capacity granularity 2:  25 mAh
model number:            03ZG
serial number:            
battery type:            LION
OEM info:                SANYO
Tue Aug  2 08:41:05 CEST 2005
$

Jan


-- 
FLASH!
Intelligence of mankind decreasing.
Details at ... uh, when the little hand is on the ....
