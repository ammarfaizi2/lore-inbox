Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTEYUlh (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTEYUlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:41:36 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:51718
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263763AbTEYUlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:41:23 -0400
Date: Sun, 25 May 2003 13:51:17 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm9
Message-ID: <20030525205117.GB23651@matchmail.com>
Mail-Followup-To: Alistair J Strachan <alistair@devzero.co.uk>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <200305251619.40137.alistair@devzero.co.uk> <20030525131512.45ce0cc2.akpm@digeo.com> <200305252135.37109.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305252135.37109.alistair@devzero.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 09:35:36PM +0100, Alistair J Strachan wrote:
> touch /home/tmp
> sync
> 
> The kernel barfed out the attached junk and the file was never committed. The 
> volume was not corrupted as I was able to reboot with -mm6 and all is fine. 
> tmp does not exist on the volume.

Be sure to run e2fsck -f on your /home partition because some changes could
have been made to the filesystem that happen before a directory entry would
be changed, suck as bitmaps or somesuch.
