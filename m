Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUKHVVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUKHVVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUKHVVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:21:44 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:27295 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261220AbUKHVV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:21:26 -0500
Date: Mon, 8 Nov 2004 22:21:00 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hanging NFS umounts with 2.4.27
Message-ID: <20041108212059.GA12717@cip.informatik.uni-erlangen.de>
References: <20041105100237.GA27689@cip.informatik.uni-erlangen.de> <1099684541.19858.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099684541.19858.1.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:55:41AM -0800, Trond Myklebust wrote:
> fr den 05.11.2004 Klokka 11:02 (+0100) skreiv Michael Gernoth:
> 
> > Searching through the Changesets I found 1.1402.1.19:
> > http://linux.bkbits.net:8080/linux-2.4/cset@1.1402.1.19
> > After reverting this one, we have a stable umount-behaviour again.
> 
> Does the attached patch help at all?
>
>   NFS: Always wake up tasks that are waiting on the sillyrenamed file to
>        complete.

This seems to fix it for us. Neither my stress-test during the weekend
nor the students today were able to reproduce the hanging umounts :-)

Thanks,
  Michael

-- 
Michael Gernoth                            Department of Computer Science IV 
Martensstrasse 1  D-91058 Erlangen Germany  University of Erlangen-Nuremberg
	         http://wwwcip.informatik.uni-erlangen.de/
