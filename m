Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbUALPWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266190AbUALPWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:22:33 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:12675
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S266171AbUALPWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:22:32 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: James Pearson <james-p@moving-picture.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4002B1D9.872714FE@moving-picture.com>
References: <4002B1D9.872714FE@moving-picture.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073920950.1639.39.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 10:22:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 12/01/2004 klokka 09:40, skreiv James Pearson:
> If mount defaults to trying TCP first then UDP if the TCP mount fails,
> should there be separate options for [rw]size depending on what type of
> mount actually takes place? e.g. 'ursize' and 'uwsize' for UDP and
> 'trsize' and 'twsize' for TCP ?

No. The number of "mount" options is complex enough as it is. I don't
see the above as being useful.
If you need the above tweak, you should be able to get round the above
problem by first attempting to force the TCP protocol yourself, and then
retrying using UDP if it fails.

Changing the default r/wsize should normally be unnecessary. You only
want to play with them if you actually see performance problems under
testing and find that you are unable to fix the cause of the packets
being dropped.

Cheers,
  Trond
