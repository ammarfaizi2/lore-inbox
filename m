Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSL1Wig>; Sat, 28 Dec 2002 17:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSL1Wig>; Sat, 28 Dec 2002 17:38:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:53221 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266316AbSL1Wif>;
	Sat, 28 Dec 2002 17:38:35 -0500
Message-ID: <3E0E29D6.9ED7CA72@digeo.com>
Date: Sat, 28 Dec 2002 14:46:46 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
References: Message from "Justin T. Gibbs" <gibbs@scsiguy.com> 
	   of "Sat, 28 Dec 2002 13:50:51 MST." <770128112.1041108651@aslan.scsiguy.com> <200212282224.gBSMO5h03843@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Dec 2002 22:46:48.0544 (UTC) FILETIME=[016AFE00:01C2AEC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> 
> gibbs@scsiguy.com said:
> > Hmm.  The only previous bug report I had in this area was related to a
> > missing cast.  That was fixed, but I guess it wasn't enough to solve
> > the problem.
> 
> It looks like possibly a config option that doesn't exist (and a possibly
> improper reliance on the dma_mask default value---which should work almost all
> the time, but it's safer to set it).
> 
> Andrew, could you try the attached (untested) patch and see if the problem
> goes away.
> 

That fixed it, thanks.   Tested with:

	CONFIG_HIGHMEM4G
	CONFIG_HIGHMEM64G, mem=4G
	CONFIG_HIGHMEM64G, (7G)
