Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWF3HsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWF3HsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWF3HsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:48:12 -0400
Received: from mail.charite.de ([160.45.207.131]:64215 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751398AbWF3HsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:48:11 -0400
Date: Fri, 30 Jun 2006 09:48:05 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>, tes@sgi.com,
       xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: held lock freed! with 2.6.17-mm3 and 2.6.17-mm4
Message-ID: <20060630074805.GE6003@charite.de>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>, tes@sgi.com,
	xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20060629203809.GD20456@charite.de> <20060630081420.A1371683@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060630081420.A1371683@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Scott <nathans@sgi.com>:
> On Thu, Jun 29, 2006 at 10:38:09PM +0200, Ralf Hildebrandt wrote:
> > 2.6.17-mm3 and mm4 both report a "BUG: held lock freed!" while booting
> > up. Find the two dmesg outputs attached.
> 
> Thanks Ralf,
> 
> From the traces, looks like it happens during the unlinked inode list
> processing, just after log recovery (I assume you crashed / rebooted
> without unmounting before this boot?).

Absolutely. The root-fs could not be umounted correctly, since the -mm3 and
-mm4 Kernels sometime produce unkillable processes. One of these
processes had files open on /, thus the reboot left me with an unclean
XFS fs!

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
