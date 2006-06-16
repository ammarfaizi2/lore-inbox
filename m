Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWFPATe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWFPATe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 20:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWFPATe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 20:19:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60378 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750782AbWFPATe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 20:19:34 -0400
Date: Fri, 16 Jun 2006 10:18:55 +1000
From: Nathan Scott <nathans@sgi.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xfs semaphore count abuse fixes
Message-ID: <20060616101855.B915318@wobbly.melbourne.sgi.com>
References: <20060615113821.GO27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060615113821.GO27946@ftp.linux.org.uk>; from viro@ftp.linux.org.uk on Thu, Jun 15, 2006 at 12:38:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 12:38:21PM +0100, Al Viro wrote:
> Kill direct access to ->count in valusema(); all we ever use it for is check
> if semaphore is actually locked, which can be trivially done in portable way.
> Code gets more reabable, while we are at it...

Thanks Al, looks good.  The naming convention you've picked is a
bit inconsistent with the rest of the code there (lacks an "a"),
I'll update it and get it merged.

cheers.

-- 
Nathan
