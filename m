Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUEVVEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUEVVEC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 17:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUEVVEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 17:04:02 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261913AbUEVVEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 17:04:00 -0400
Date: Sat, 22 May 2004 22:10:42 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405222110.i4MLAg97000214@81-2-122-30.bradfords.org.uk>
To: JG <jg@cms.ac>
Cc: Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>,
       system <system@eluminoustechnologies.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040522165404.5BF5A1A9B70@23.cms.ac> 
References: <200405221257.28570.system@eluminoustechnologies.com>
 <Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
 <200405221622.i4MGMuhD000211@81-2-122-30.bradfords.org.uk>
 <20040522165404.5BF5A1A9B70@23.cms.ac>
Subject: Re: hda Kernel error!!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from JG <jg@cms.ac>:
> --Signature=_Sat__22_May_2004_18_53_54_+0200_tMfzaYq4HdZNA_y9
> Content-Type: text/plain; charset=US-ASCII
> Content-Disposition: inline
> Content-Transfer-Encoding: 7bit
> 
>  
> > It does not necessarily indicate a serious problem.  Are you sure your
> > error messages were exactly the same?
> 
> while we are at it. some days ago i got this:
> hdi: task_in_intr: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
> hdi: task_in_intr: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=280923064991615, high=16744319, low=8355711, sector=1130361
> ide4: reset: success

Look at the LBAsect requested - this is far beyond the end of the disk, which
explains why it returned address mark not found - the sector doesn't exist.

John.
