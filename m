Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVA2Rok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVA2Rok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVA2Roj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:44:39 -0500
Received: from mail1.kontent.de ([81.88.34.36]:5101 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261376AbVA2Roe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:44:34 -0500
From: Oliver Neukum <oliver@neukum.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Ooops unmounting a defect DVD
Date: Sat, 29 Jan 2005 18:44:41 +0100
User-Agent: KMail/1.7.1
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1107009976.4535.13.camel@mulgrave>
In-Reply-To: <1107009976.4535.13.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501291844.41290.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 29. Januar 2005 15:46 schrieb James Bottomley:
> I wouldn't have noticed this at all since you didn't send it to the scsi
> list, but fortunately, Al Viro drew it politely to my attention as
> another example of SCSI refcounting problems.

Sorry, it happening in cdrom_release fooled me into considering it
a generic cdrom problem.

> The issue seems to be that we have a spurious scsi_cd_put() on the error
> path of sr_open().  The sr_block_..() functions are the "real" block
> opens and should be refcounted, the sr_...() are the pseudo cdrom opens
> and should not be refcounted.
> 
> Could you try this and see if it fixes the problem?

It fully fixes the problem. Thank you.

	Regards
		Oliver
