Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTIZAHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 20:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTIZAHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 20:07:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262086AbTIZAHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 20:07:34 -0400
Message-ID: <3F73833A.2000909@pobox.com>
Date: Thu, 25 Sep 2003 20:07:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Dickson <SteveD@redhat.com>
CC: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       trond.myklebust@fys.uio.no
Subject: Re: [PATCH v2] reduce NFS stack usage
References: <mailman.1064420466.30286.linux-kernel2news@redhat.com> <3F7335B4.1070002@RedHat.com>
In-Reply-To: <3F7335B4.1070002@RedHat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Dickson wrote:
> Hey Jeff,
> 
> Question:
> Why are only nfs_lookup_revalidate() and nfs_readdir()
> a problem and not the other 4 ops (like nfs_lookup())?
> Is the case only those two showed up in the stack overflow
> oops trace?

You guessed it...  I'm sure other routines are problematic, but those 
were two that showed up in traces.


> Also, not like there much choice in matter, but I wonder what
> type of performance hit (if any) there will be by making
> these routines call kmalloc()... lookups and readdirs are
> pretty popular ops...

Sure.  I wasn't suggesting by any means my patch is the ultimate 
solution :)  Creating a slab cache would be easy enough...

	Jeff




