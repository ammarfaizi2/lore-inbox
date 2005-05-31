Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVEaTrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVEaTrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVEaTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:47:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55203 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261342AbVEaTrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:47:06 -0400
Subject: Re: RT : 2.6.12rc5 + realtime-preempt-2.6.12-rc5-V0.7.47-15
From: Lee Revell <rlrevell@joe-job.com>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1117551231.19367.48.camel@ibiza.btsn.frna.bull.fr>
References: <1117551231.19367.48.camel@ibiza.btsn.frna.bull.fr>
Content-Type: text/plain
Date: Tue, 31 May 2005 15:47:04 -0400
Message-Id: <1117568825.23283.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 16:53 +0200, Serge Noiraud wrote:
> I have a test program which made a loop in RT to mesure the system
> perturbation.
> It works finely in a tty environment.
> When I run it in an X environment ( xterm ), I get something like if I
> click the Enter key in the active window.
> If I open a new xterm, this is the new active window which receive these
> events.
> These events stop when the program stop.
> 
> I tried with X in RT and no RT : I have the problem.

Try adding:

Option "NoAccel"

to the Driver section of your X config.

Some buggy video drivers can stall the PCI bus for tens or hundreds of
*milliseconds*.  The "via" driver had this problem until I identified
the problem and the Unichrome guys fixed it.  If it goes away with
"NoAccel", then you are having the same problem.

For details search the unichrome-devel archives for "losing interrupts".

Lee

