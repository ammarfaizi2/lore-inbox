Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVGKHp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVGKHp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 03:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVGKHp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 03:45:58 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:31622 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261224AbVGKHpy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 03:45:54 -0400
Subject: Re: aio-stress throughput regressions from 2.6.11 to 2.6.12
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050701075600.GC4625@in.ibm.com>
References: <20050701075600.GC4625@in.ibm.com>
Date: Mon, 11 Jul 2005 09:43:06 +0200
Message-Id: <1121067786.2196.62.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/07/2005 09:55:54,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/07/2005 09:57:38,
	Serialize complete at 11/07/2005 09:57:38
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-01 at 13:26 +0530, Suparna Bhattacharya wrote:
> Has anyone else noticed major throughput regressions for random
> reads/writes with aio-stress in 2.6.12 ?
> Or have there been any other FS/IO regressions lately ?
> 
> On one test system I see a degradation from around 17+ MB/s to 11MB/s
> for random O_DIRECT AIO (aio-stress -o3 testext3/rwfile5) from 2.6.11
> to 2.6.12. It doesn't seem filesystem specific. Not good :(
> 
> BTW, Chris/Ben, it doesn't look like the changes to aio.c have had an impact
> (I copied those back to my 2.6.11 tree and tried the runs with no effect)
> So it is something else ...
> 
> Ideas/thoughts/observations ?
> 
> Regards
> Suparna
> 

  I'm too seeing a regression, but between 2.6.10 and 2.6.12 and using
sysbench + MySQL (with POSIX AIO). The difference is roughly 8% slower
for 2.6.12. I'm currently trying to trace it.

  aio-stress shows no difference so it probably does not come from
kernel AIO.

  Sébastien.


-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

