Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTEWRNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTEWRNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:13:04 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:5767 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264103AbTEWRNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:13:04 -0400
Date: Fri, 23 May 2003 12:39:41 -0400
From: Ben Collins <bcollins@debian.org>
To: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc3 : 1394 : Cannot detect hard drive(s?).
Message-ID: <20030523163941.GL400@phunnypharm.org>
References: <20030524.021635.74748205.whatisthis@jcom.home.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030524.021635.74748205.whatisthis@jcom.home.ne.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 02:16:35AM +0900, Kyuma Ohta wrote:
> Hi,
> After 2.4.21-rc2,driver of IEEE1394 storage ( a.k.a. sbp2 ) is not able to
> detect IEEE1394 Hard Drive.

Please read the SBP-2 info on www.linux1394.org. You can either use the
rescan-scsi-bus.sh script, or the controversial add_single/remove_single
patch for the scsi layer.

SCSI is not hotplug capable per-device in 2.4. Any hint of this being
possible from the past with SBP-2 is accidental and not supported.

If you want real SCSI/SBP-2 hotplug support, use 2.5.69.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
