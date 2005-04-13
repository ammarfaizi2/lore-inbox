Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVDMTjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVDMTjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVDMTjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:39:42 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:14300 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261216AbVDMTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:39:25 -0400
Date: Wed, 13 Apr 2005 15:39:24 -0400
To: aeriksson@fastmail.fm
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD writer and IDE support...
Message-ID: <20050413193924.GN521@csclub.uwaterloo.ca>
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org> <20050413183722.GQ17865@csclub.uwaterloo.ca> <20050413190756.54474240480@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413190756.54474240480@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 09:07:56PM +0200, aeriksson@fastmail.fm wrote:
> It's with 2.6.11.7

Probably close to the 2.6.11 kernel I run on Debian-pure64/sarge.

> Dunno yet. What's the fastest way to dump a file to a (fs on) a blank 
> 4.7 GB DVD RW? As I said this is not my home turf so I have to read 
> up on the commands to use (I guess I'm not dd'ing an iso image to 
> /dev/hdc...)

growisofs -Z /dev/hdc -J -R /path/to/dir/with/less/than/4.5GB/of/files

That should do it.  To do scsi I suspect it would be /dev/sg0 or
/dev/scd0.  I haven't actually tried burning in scsi emulation mode with
these drives.

growisofs is part of dvd+rw-tools.  It will autoformat the disc if
needed.

Len Sorensen
