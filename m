Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269960AbRHJRpY>; Fri, 10 Aug 2001 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269961AbRHJRpO>; Fri, 10 Aug 2001 13:45:14 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:27017
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S269960AbRHJRo5>; Fri, 10 Aug 2001 13:44:57 -0400
Date: Fri, 10 Aug 2001 10:44:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christian Borntraeger <CBORNTRA@de.ibm.com>, ext3-users@redhat.com,
        linux-kernel@vger.kernel.org, Carsten Otte <COTTE@de.ibm.com>
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
Message-ID: <20010810104450.F31136@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com> <3B72DD66.A6F65247@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B72DD66.A6F65247@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 11:58:46AM -0700, Andrew Morton wrote:
> Christian Borntraeger wrote:
> > 
> > Hello ext3-users,
> > 
> > I tested ext3 on a Linux for S/390 with several stress and benchmark test
> > tests and faced a kernel bug message.
> > The console showed the following output:
> > 
> > Message from syslogd@boeaet34 at Fri Aug  3 11:34:16 2001 ...
> > boeaet34 kernel: Assertion failure in journal_forget() at
> > transaction.c:1184: "!
> > jh->b_committed_data"
> > 
> 
> Simple bug, subtle symptoms.  Could you please retest 0.9.5
> with this patch?  Thanks.

With this patch my first oops seems to have gone away.  I'm repeating
the test again, but dbench'ing 2,4,8,16,32 and then 64 (until disk
space ran out) worked this time.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
