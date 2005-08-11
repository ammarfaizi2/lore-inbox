Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVHKSs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVHKSs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVHKSs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:48:57 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:5536 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932357AbVHKSs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:48:56 -0400
To: Simon Derr <Simon.Derr@bull.net>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-scsi-owner@vger.kernel.org, mingo@redhat.com
MIME-Version: 1.0
Subject: Re: [PATCH] remove name length check in a workqueue
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
X-MIMETrack: S/MIME Sign by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11
  |July 24, 2002) at 11.08.2005 20:47:08,
	Serialize by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11  |July
 24, 2002) at 11.08.2005 20:47:08,
	Serialize complete at 11.08.2005 20:47:08,
	S/MIME Sign failed at 11.08.2005 20:47:08: The cryptographic key was not
 found,
	Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 11/08/2005 20:48:53,
	Serialize complete at 11/08/2005 20:48:53
Message-ID: <OFCE6F94E7.B33AAE6C-ONC125705A.00670256-C125705A.0067378D@de.ibm.com>
Date: Thu, 11 Aug 2005 20:48:50 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Simon Derr <Simon.Derr@bull.net> wrote:

  > It is sufficient to have a few HBAs and to insmod/rmmod the driver a 
few 
  > times.

  > Since the host_no is choosen with a mere counter increment 
  > in scsi_host_alloc():

  >       shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */

  > Unused `host_no's are not reused and the 100 limit is reached even on 
  > smaller systems.

  > I have no idea of why someone would do repeated insmod/rmmods, though.
  > (But someone did).

You even don't have to use insmod/rmmod.  On s390 (using zfcp) it
suffices to take adapters offline and online (triggered via VM,
hardware, or within Linux). Just do so about 100 times ... You
know the result.


Regards,

Andreas
