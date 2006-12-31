Return-Path: <linux-kernel-owner+w=401wt.eu-S932541AbWLaBUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWLaBUH (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWLaBUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:20:07 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:60786 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932541AbWLaBUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:20:05 -0500
Message-ID: <45971053.7040609@lwfinger.net>
Date: Sat, 30 Dec 2006 19:20:19 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Stephen Hemminger <shemminger@osdl.org>
Subject: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a new laptop - an HP Pavilion dv2125nr with an AMD Turion 64 X2 Mobile CPU. With any kernel
later than 2.6.18, the sound does not work. The audio interface is reported by lspci as "Audio
device: nVidia Corporation MCP51 High Definition Audio (rev a2)", and uses the snd_hda_intel module.

Using git bisect, I determined that there are two problems. If commit a7da6ce564a8092..., which is
entitled "hda-codec-Add independent headphone volume control" is present, I get no sound at all.
When this commit is reverted, I get sound, but playing a sound file results in about an 0.5 sec
fragment being replayed over and over forever. If commit 7376d013fc6d3a45..., which is entitled
"Simple patch to enable Message Signalled Interrupts for the HDA Intel audio controller" is
reverted, the sound works fine.

Please tell me what other information is required.

Larry


