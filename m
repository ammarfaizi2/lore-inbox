Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVBRR0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVBRR0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVBRR0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:26:49 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:1035 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261420AbVBRR0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:26:43 -0500
Date: Fri, 18 Feb 2005 18:26:36 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Kurt Garloff <garloff@suse.de>, Joe Krahn <krahn@niehs.nih.gov>,
       linux-kernel@vger.kernel.org
Subject: Re: Bogus REPORT_LUNS responses breaks SCSI LUN detection
Message-ID: <20050218172636.GA8250@pclin040.win.tue.nl>
References: <41DF1D96.6030109@niehs.nih.gov> <20050214045100.GA27893@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214045100.GA27893@tpkurt.garloff.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : pastinakel.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 11:51:00PM -0500, Kurt Garloff wrote:

> > SuSE 9.1
> > Vendor: easyRAID Model: X16 Rev: 0001
> > Type: Direct-Access ANSI SCSI revision: 03
> > scsi: host 0 channel 0 id 5 lun 0x6500737952414944 has a LUN larger than 
> > currently supported.
> 
> Looks like random garbage.

I read "e syRAID"

> > Kernel 2.6, unknown distro
> > Vendor: transtec  Model:                   Rev: 0001
> > Type:   Direct-Access                      ANSI SCSI revision: 03
> > On host 1 channel 0 id 1 only 128 (max_scsi_report_luns) of 536870896 
> > luns reported, try increasing max_scsi_report_luns.
> > scsi: host 1 channel 0 id 1 lun 0x7400616e73746563 has a LUN larger than 
> > currently supported.

I read "t anstec"

So - you might wish to investigate why the 2nd byte of "easyRAID" and
of "transtec" was zeroed, and whether contents like this was to be
expected (maybe the previous command was IDENTIFY?).

Andries
