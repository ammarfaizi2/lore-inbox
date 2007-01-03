Return-Path: <linux-kernel-owner+w=401wt.eu-S932134AbXACWBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbXACWBb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbXACWBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:01:31 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:43624 "EHLO
	janus.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932116AbXACWBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:01:30 -0500
Date: Wed, 3 Jan 2007 23:01:29 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Finding hardlinks
Message-ID: <20070103220129.GA4788@janus>
References: <20070103185815.GA2182@janus> <OF9726A29A.AA3902E2-ON85257258.0072E396-88257258.00740500@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9726A29A.AA3902E2-ON85257258.0072E396-88257258.00740500@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 01:09:41PM -0800, Bryan Henderson wrote:
> >On any decent filesystem st_ino should uniquely identify an object and
> >reliably provide hardlink information. The UNIX world has relied upon 
> this
> >for decades. A filesystem with st_ino collisions without being hardlinked
> >(or the other way around) needs a fix.
> 
> But for at least the last of those decades, filesystems that could not do 
> that were not uncommon.  They had to present 32 bit inode numbers and 
> either allowed more than 4G files or just didn't have the means of 
> assigning inode numbers with the proper uniqueness to files.  And the sky 
> did not fall.  I don't have an explanation why,

I think it's mostly high end use and high end users tend to understand
more. But we're going to see more really large filesystems in "normal"
use so..

Currently, large file support is already necessary to handle dvd and
video. It's also useful for images for virtualization. So the failing stat()
calls should already be a thing of the past with modern distributions.

-- 
Frank
