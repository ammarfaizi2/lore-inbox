Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTFKWBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTFKWBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:01:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44459 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264559AbTFKWBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:01:37 -0400
Subject: Re: 2.5.70-mm6
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbadari@us.ibm.com
In-Reply-To: <20030610201242.7fde819b.akpm@digeo.com>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<3EE690AC.70500@us.ibm.com>  <20030610201242.7fde819b.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Jun 2003 15:15:06 -0700
Message-Id: <1055369707.7509.8.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 20:12, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > I run 50 fsx tests on ext3 filesystem on 2.5.70-mm6 kernel. Serveral fsx 
> >  tests hang with the status D, after the tests run for a while.  No oops, 
> >  no error messages.  I found same problem on mm5, but 2.5.70 is fine.
> > 
> >  Here is the stack info:
> 
> Thanks for this.
> 
> Everything is waiting on I/O.  It looks like either the device driver
> failed or the IO scheduler got its state all screwed up.
> 
> Which device driver are you using there?

I am usering Qlogic qla2xxx V8 driver
> 
> If you could, please retest with "elevator=deadline"?
> 
Sure.

And I saw sysrq on 2.5.70-mm6 failed on my test machine, 2.5.70-mm5
works.  I could trigger sysrq by send"t", but the stack info for all
threads are the same ---the stack info of the sysrq itself.


