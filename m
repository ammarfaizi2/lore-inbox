Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263649AbTDIR4x (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTDIR4x (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:56:53 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:12015 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S263649AbTDIR4w (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 13:56:52 -0400
Date: Wed, 9 Apr 2003 14:08:32 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ?
Message-ID: <20030409140832.A4621@redhat.com>
References: <20030409141608.A12136@verdi.et.tudelft.nl> <20030409154836.GA31739@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030409154836.GA31739@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Wed, Apr 09, 2003 at 08:48:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 08:48:36AM -0700, Joel Becker wrote:
> 	In 2.5, the alignment restrictions have been relaxed.  Your
> offset, buffer, and transfer size must all be aligned on the hardware
> sector size.  That is the output of BLKSSZGET against the block device,
> and is also what get_hardsect_size() returns in the kernel.  For almost
> all disks this number is 512b, so you can do O_DIRECT on 512b alignment
> for a raw disk or for an ext3 filesystem.  About the only thing that
> may not have a 512b hardware sector size is a CD-ROM.

Well, and SCSI devices configured to use 528 byte sectors and such...

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
