Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWJZRIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWJZRIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161218AbWJZRIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:08:22 -0400
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:31916 "EHLO
	aa013msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161157AbWJZRIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:08:22 -0400
Message-ID: <001501c6f921$56c3fe40$2b20ff27@flaviopc>
From: "Inter filmati" <interfc@jumpy.it>
To: <linux-kernel@vger.kernel.org>
Subject: cpufreq/powernowd limiting CPU frequency on kernels >=2.6.16
Date: Thu, 26 Oct 2006 19:08:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Antivirus: avast! (VPS 0643-5, 26/10/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most recent kernel where this bug did not occur:2.6.15
Distribution:Ubuntu64bit
Hardware Environment: X2 3800+, DFI NF4 Ultra-D, X800GT
Software Environment:
Problem Description: I overclocked via bios my cpu (factory: 200x10) to 
2565mhz
(285x9), and I haven't any problems 'til 2.6.15, it goes down to 285x5 in 
idle
and up to 285x9 in full load. If I upgrade to a newer kernel, it says 1ghz 
in
idle and 1,8ghz in full load (I wonder it takes the fsb value, that is 
200mhz,
directly form cpu and not from the bios, so it assumes 200x5 in idle and 
200x9
in full load)
flapane@a64:~$ cpufreq-info
cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux@brodo.de, please.
analyzing CPU 0:
  driver: powernow-k8
  CPUs which need to switch frequency at the same time: 0 1
  hardware limits: 1000 MHz - 1.80 GHz
  available frequency steps: 1.80 GHz, 1000 MHz
  available cpufreq governors: userspace, powersave, ondemand, conservative,
performance
  current policy: frequency should be within 1000 MHz and 1.80 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1000 MHz.
analyzing CPU 1:
  driver: powernow-k8
  CPUs which need to switch frequency at the same time: 0 1
  hardware limits: 1000 MHz - 1.80 GHz
  available frequency steps: 1.80 GHz, 1000 MHz
  available cpufreq governors: userspace, powersave, ondemand, conservative,
performance
  current policy: frequency should be within 1000 MHz and 1.80 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1000 MHz.


Steps to reproduce:
simply compile a kernel >=2.6.16 and try to overclock your cpu from the bios
raising the FSB (or HT)

Flavio
www.flapane.com 

