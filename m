Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUEXXFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUEXXFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUEXXFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:05:14 -0400
Received: from blv-smtpout-01.boeing.com ([130.76.32.69]:22430 "EHLO
	blv-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id S263687AbUEXXFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:05:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: your mail
Date: Mon, 24 May 2004 16:04:43 -0700
Message-ID: <67B3A7DA6591BE439001F2736233351202B47E76@xch-nw-28.nw.nos.boeing.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: your mail
Thread-Index: AcRB3rWxS3t/fSZbQyuzYPQV2Avy4gABIPXw
From: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
To: "Herbert Poetzl" <herbert@13thfloor.at>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2004 23:04:44.0030 (UTC) FILETIME=[805EE1E0:01C441E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Herbert Poetzl [mailto:herbert@13thfloor.at] 
> Sent: Monday, May 24, 2004 3:30 PM
> To: Laughlin, Joseph V
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: your mail
> 
> 
> On Mon, May 24, 2004 at 03:20:33PM -0700, Laughlin, Joseph V wrote:
> > I've been tasked with modifying a 2.4 kernel so that a 
> non-root user 
> > can do the following:
> > 
> > Dynamically change the priorities of processes (up and down) Lock 
> > processes in memory Can change process cpu affinity
> > 
> > Anyone got any ideas about how I could start doing this?  
> (I'm new to 
> > kernel development, btw.)
> 
> check the kernel capability system ...
> (it's quite simple)
> 
> #define CAP_SYS_NICE         23
> #define CAP_IPC_LOCK         14
> 
> cpu scheduler affinity isn't part of 2.4 AFAIK
> so there is no easy way to 'control' it ...
> 

Currently, we're using sched_setaffinity() to control it, which existed
in our 2.4.19 kernel.  (but, you have to be root to use it, and we'd
like non-root users to be able to change the affinity.)

Joe

