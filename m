Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbVAFX6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbVAFX6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVAFXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:54:54 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:21881 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S263119AbVAFXuq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:50:46 -0500
X-Ironport-AV: i="3.88,108,1102312800"; 
   d="scan'208"; a="177404593:sNHT27031058"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Thu, 6 Jan 2005 17:50:40 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D33@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcTAIAVAVRscS9MSR36xZTS1/gcpSAADEUdwDPQ/CKAAEI5dwAACYitQ
From: <Tim_T_Murphy@Dell.com>
To: <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2005 23:50:41.0245 (UTC) FILETIME=[8791C0D0:01C4F44A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> this patch fixes the problem for me, but its probably an awful hack --

> a brief interrupt storm occurs until tty processes its buffer, 
> but IMHO that's better than dropping characters.

sorry, i see now that its not an interrupt storm but rather the
interrupt handler doesn't end until it quits due to 'too much work'.

tim
