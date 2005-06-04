Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVFDTUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFDTUa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVFDTUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 15:20:30 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:36746 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261428AbVFDTUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 15:20:19 -0400
Date: Sat, 4 Jun 2005 15:19:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Adrian Bunk <bunk@stusta.de>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
Message-ID: <20050604191958.GA13111@havoc.gtf.org>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com> <42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de> <42A1FB91.5060702@pobox.com> <87psv2j5mb.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psv2j5mb.fsf@stark.xeocode.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 03:15:24PM -0400, Greg Stark wrote:
> So my question is, if I did tackle this riddle trail and figured out how to
> fetch the passthru branch against 2.6.12, what would it buy me? Would SMART
> just start working? Or would it just confuse the SMART tools until they're
> updated? Or would it just crash my machine?

SMART should just start working.  It adds the ioctls that existing smartd
and hdparm already know about.

The two reasons why passthru is not upstream are:

* I need to make sure that it is 100% up-to-date for the latest ATA
passthru spec, which clarified some SCSI CDB and descriptor codes.

* There was at least one report of ATA passthru use causing a device
under load to start timing out, which could possibly indicate a driver
bug.  I need to do a serious analysis and final review of the patch, to
make sure that it is plugged into the ATA host state machine at the
correct places.

	Jeff





