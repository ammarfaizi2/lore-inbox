Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269901AbUJGXGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269901AbUJGXGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269912AbUJGXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:00:53 -0400
Received: from holomorphy.com ([207.189.100.168]:39890 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269897AbUJGWtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:49:50 -0400
Date: Thu, 7 Oct 2004 15:49:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec drivers and 2.6.x kernels
Message-ID: <20041007224927.GZ9106@holomorphy.com>
References: <20041007222709.GA24314@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007222709.GA24314@animx.eu.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 06:27:09PM -0400, Wakko Warner wrote:
> I've been irritated with this for some time now.  I've seen this with 2.6.7
> and 2.6.8.1 with both aic7xxx and aic79xx drivers.
> I have a bad CD (I burned it as fast as my burner could force.  I expected
> errors).  The scsi drivers do not handle errors very well.  I tried to read
> this bad cd on an ide cdrom (I have 2 one on hda and one on hdd), it just
> gives up with a read error.  If I do this on scd0 or scd1 (scd0 is an LG DVD
> multi burner using an acard u2w scsi to udma66 converter, scd1 is a plextor
> cdrw 40/12/40 narrow scsi), then the driver offlines the drive and I can't
> use it anymore.
> With this problem, the device recovered with scd1.  It was a simple:
> cd /proc/scsi
> echo "scsi remove-single-device 2 0 1 0" > scsi
> echo "scsi add-single-device 2 0 1 0" > scsi
> And it now works again.  Sometimes it doesn't.  scsi bus 0 and 1 are on the
> aic79xx [...]

I have boxen with aic7xxx and aic79xx that don't see issues of this
kind (granted, with bleeding edge -mm). Could you describe the systems
in more detail?


-- wli
