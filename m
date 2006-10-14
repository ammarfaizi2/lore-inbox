Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752145AbWJNKvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbWJNKvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 06:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbWJNKvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 06:51:45 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:46514 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1752146AbWJNKvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 06:51:44 -0400
Date: Sat, 14 Oct 2006 12:51:42 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, ryan@tau.solarneutrino.net,
       linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061014105142.GN3039@mail.muni.cz>
References: <452FA451.6090702@intel.com> <20061013232248.83292.qmail@web83107.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061013232248.83292.qmail@web83107.mail.mud.yahoo.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 147.251.54.96
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 04:22:48PM -0700, Aleksey Gorelov wrote:
>  It looks like the reason for reboot failure is unability of BIOS to reboot if network pci device
> is in D3 state. Once I've added 
>  	pci_set_power_state(pdev, PCI_D0);
> as a last line to e1000_shutdown() method, board started rebooting again.
> Moreover, here is what I found in release notes to the latest BIOS (from October 5, 2006):
> "Fixed an issue where system not able to shutdown to S5 if the LAN is set to D3 mode."
> This may have affected reboot with LAN in D3 negatively.
>   I guess you are in the best position of all of us to bring the issue to Intel BIOS team. 

The fixed shutdown to S5 is present in latest BIOS version only.
However, the bug has been present since 1162 BIOS version.    

-- 
Luká¹ Hejtmánek
