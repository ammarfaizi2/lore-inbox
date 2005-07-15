Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVGOLlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVGOLlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGOLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:41:50 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:42376 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261177AbVGOLlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:41:49 -0400
Date: Fri, 15 Jul 2005 12:38:39 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Christoph Lameter <christoph@lameter.com>
cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org
Subject: [OT] high precision hardware (was Re: [PATCH] i386: Selectable
 Frequency of the Timer Interrupt)
In-Reply-To: <Pine.LNX.4.62.0507140757200.31521@graphe.net>
Message-ID: <Pine.LNX.4.63.0507151227240.31084@sheen.jakma.org>
References: <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>
  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
  <20050713211650.GA12127@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <20050714083843.GA4851@elte.hu> <1121352941.4535.15.camel@mindpipe>
 <Pine.LNX.4.62.0507140757200.31521@graphe.net>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005, Christoph Lameter wrote:

> Linux can already provide a response time within < 3 usecs from 
> user space using f.e. the Altix RTC driver which can generate an 
> interrupt that then sends a signal to an application. The Altix RTC 
> clock is supported via POSIX timer syscalls and can be accessed 
> using CLOCK_SGI_CYCLE. This has been available in Linux since last 
> fall and events can be specified with 50 nanoseconds accurary.

Out of curiosity, are there any cheap and 'embeddable' linux 
supported architectures which support such response times (User or 
kernel space)?

Would be very interested for a hobby project I'm planning 
(programmable digital ignition) which requires about 10usec 
resolution +/- 6us accuracy response times. At moment looks like this 
task will have to done on a dedicated microcontroller.

Input comes in at anywhere from 6kHz to 100kHz (variable), (T0 say), 
requirement is to assert an output line Ta seconds after each T0, Ta 
needs to be accurate to about 6us in the extreme case (how long the 
output is held has similar accuracy requirement).

What kind of hardware is capable of this? Even in microcontroller 
space it's difficult to do (eg looked at some ARM microcontrollers, 
which still have several usec of interrupt latency - even with no OS, 
still likely cant use timers and interrupts.).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
The church saves sinners, but science seeks to stop their manufacture.
 		-- Elbert Hubbard
