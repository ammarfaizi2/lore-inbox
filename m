Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVBVM2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVBVM2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVBVM2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:28:44 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27652 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262293AbVBVM1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:27:21 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
Date: Tue, 22 Feb 2005 14:26:58 +0200
User-Agent: KMail/1.5.4
References: <421A3414.2020508@nodivisions.com> <421B12DB.70603@aitel.hist.no> <421B14A8.3000501@nodivisions.com>
In-Reply-To: <421B14A8.3000501@nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502221426.58973.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 February 2005 13:16, Anthony DiSante wrote:
> Helge Hafting wrote:
> > The infrastructure for that does not exist, so instead, the "killed" 
> > process remains. Not all of it, but at least the memory pinned down by 
> > the io request.  This overhead is typically small, and the overehad of 
> > adding forced io abort to every driver might
> > be larger than a handful of stuck processes.  It looks ugly, but perhaps 
> > a ps flag that hides the ugly processes is enough.
> 
> I don't care about any overhead associated with stuck processes, nor do I 
> care that they look ugly in the ps output.  What I care about is the fact 
> that at least once a week on multiple systems with different hardware, some 
> HW-related driver/process gets stuck, then immediately cascades its 
> stuckness up to udevd or hald, and then I can't use any of my hardware 
> anymore until I reboot.

This was discussed to death before. There will never be a "D-state" killer. Period.

If you want to get rid of your stuck processes, you need to fix the bug
or at least let lkml people know about it (this was already explained to you!).
--
vda

