Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288668AbSA3NVf>; Wed, 30 Jan 2002 08:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSA3NVZ>; Wed, 30 Jan 2002 08:21:25 -0500
Received: from [62.245.135.174] ([62.245.135.174]:38336 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S288668AbSA3NVU>;
	Wed, 30 Jan 2002 08:21:20 -0500
Message-ID: <3C57F347.26527F73@TeraPort.de>
Date: Wed, 30 Jan 2002 14:21:11 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre4-J0-VM-22-preempt-lock i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: jfv@trane.bluesong.net
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: O(1) 2.4.17-J7 Tuneable Parameters
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/30/2002 02:21:10 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/30/2002 02:21:20 PM,
	Serialize complete at 01/30/2002 02:21:20 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [PATCH]: O(1) 2.4.17-J7 Tuneable Parameters
> 
> 
> Hi Ingo,
> 
>         This patch synchronizes with J7 and I think makes the changes
> you wished. A couple of important points:
> 
>                 - This patch can be applied to EITHER 2.4.17 OR 2.4.18 pre 7 as
>                         long as Ingo's J7 patch is applied first.
> 
>                 - While I agree with you on not wanting these in the mainline kernel,
>                         I ran Hackbench on one of our new Foster systems with and
>                         without the tuneable parameters, and while the numbers do
>                         degrade slightly, its rather suprisingly small. So dont be afraid
>                         to use this as a system tuning aid.
> 

 How big is the actual degradation in your test? IIR, Ingo is afraid
that the tunables could easily screw things up, which of course is true.
What about adding a kernel-build option that leaves the sysctl interface
read-only by default and enables writing only if it is requested at
build time?

 That way the external interface stays constant.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
