Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUDBU1I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUDBU1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:27:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:60566 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264174AbUDBU1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:27:04 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] lockfs patch for 2.6
Date: Fri, 2 Apr 2004 14:26:04 -0600
User-Agent: KMail/1.6
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
       thornber@redhat.com
References: <1078867885.25075.1458.camel@watt.suse.com> <200404021400.18583.kevcorry@us.ibm.com> <20040402210257.A7440@infradead.org>
In-Reply-To: <20040402210257.A7440@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404021426.04622.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 April 2004 2:02 pm, Christoph Hellwig wrote:
> On Fri, Apr 02, 2004 at 02:00:18PM -0600, Kevin Corry wrote:
> > > Christoph's vfs patch looks good, I've stripped out the XFS bits (FS
> > > parts should probably be in different patches) and made one small
> > > change.  freeze/thaw now check to make sure bdev != NULL.
> >
> > Does this mean there are patches required for XFS to work properly with
> > this new VFS-lock patch? I'm getting hangs when suspending a DM device
> > that contains an XFS filesystem with active I/O. Ext3, Reiser, and JFS
> > seem to behave as expected.
>
> Yes.  Here's the patch I sent out earlier (xfs bits + common code):

Thanks. Sorry I missed your patch the first time around. XFS works as expected 
now.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
