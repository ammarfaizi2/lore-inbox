Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVFXAcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVFXAcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 20:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVFXAcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 20:32:31 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16531 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262925AbVFXAcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:32:24 -0400
Subject: Re: aic79xx -> can't  suspend
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050623193224.GD2251@voodoo>
References: <1119549104.13259.1.camel@mindpipe>
	 <20050623193224.GD2251@voodoo>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 20:32:22 -0400
Message-Id: <1119573142.20628.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-23 at 15:32 -0400, Jim Crilly wrote:
> On 06/23/05 01:51:43PM -0400, Lee Revell wrote:
> > I have a machine with an Adaptec 2940U2W adapter running 2.6.11.
> > When I try to go into standby like so:
> > 
> >     echo standby > /sys/power/state
> > 
> > this is what happens:
> 
> AFAIK no SCSI drivers have had power management functions implemented,
> a quick grep for PM_ in drivers/scsi seems to confirm that only the
> PCMCIA SCSI drivers even look for PM events. 

Actually it is implemented in the aic7xxx driver, see ahc_suspend and
ahc_resume.

I tried it with 2.6.12, and I no longer have the problem with the ahc_dv
thread as it no longer exists (AFAICT the functionality is handled by
the SCSI midlayer now?).

Now it just immediately resumes:

[4297399.286000] PM: Preparing system for standby sleep
[4297399.609000] Stopping tasks: ================================|
[4297399.610000] Restarting tasks... done

How can I debug this further?

Lee



