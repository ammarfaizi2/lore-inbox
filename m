Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTJBObu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbTJBObu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:31:50 -0400
Received: from cpout2.tiscali.be ([62.235.13.194]:62703 "EHLO
	cpout2.tiscali.be") by vger.kernel.org with ESMTP id S263358AbTJBObs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:31:48 -0400
Date: Thu, 2 Oct 2003 16:31:46 +0200
Message-ID: <3F4E0D2500025C61@ocpmta9.freegates.net>
From: ealgera@tiscali.nl
Subject: Wake On Lan 2.4.20 & Boot scripts
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

My network card (nvidia) is capable of Wake on Lan.
When I issue the following commands from the command line, the system shuts
down immediately and powers up on Wake on Lan:
pci-config -#12 -S
/sbin/halt -hdf

(pci-config from scyld.com)

However, when I put those commands in the /etc/init.d/halt.sh script, the
system won't wake up. ( I put a 'sleep 3' command in between the two others
to give pci-config the time to work) 

I have APM in my kernel as follows: (ACPI disabled)

[*] Power Management support                                            
 &#9474; &#9474;
  &#9474; &#9474;                        <*>   Advanced Power Management
BIOS support                              &#9474; &#9474;
  &#9474; &#9474;                        [ ]     Ignore USER SUSPEND    
                                          &#9474; &#9474;
  &#9474; &#9474;                        [*]     Enable PM at boot time 
                                          &#9474; &#9474;
  &#9474; &#9474;                        [*]     Make CPU Idle calls when
idle                                     &#9474; &#9474;
  &#9474; &#9474;                        [ ]     Enable console blanking
using APM                                 &#9474; &#9474;
  &#9474; &#9474;                        [ ]     RTC stores time in GMT 
                                          &#9474; &#9474;
  &#9474; &#9474;                        [*]     Allow interrupts during
APM BIOS calls                            &#9474; &#9474;
  &#9474; &#9474;                        [*]     Use real mode APM BIOS call
to power off    


I use gentoo with the gentoo-kernel-2.4.20-r7.

Has anyone a clue why the wake on lan doesn't work from the shutdown scripts,
and does work from the commandline?

Thanks,
Elton Algera

