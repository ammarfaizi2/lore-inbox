Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269962AbRHJSFF>; Fri, 10 Aug 2001 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269963AbRHJSE4>; Fri, 10 Aug 2001 14:04:56 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:13830 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269962AbRHJSEm>; Fri, 10 Aug 2001 14:04:42 -0400
Message-ID: <3B74235F.8F6943D9@zip.com.au>
Date: Fri, 10 Aug 2001 11:09:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Christian Borntraeger <CBORNTRA@de.ibm.com>, ext3-users@redhat.com,
        linux-kernel@vger.kernel.org, Carsten Otte <COTTE@de.ibm.com>
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
In-Reply-To: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com> <3B72DD66.A6F65247@zip.com.au>,
		<3B72DD66.A6F65247@zip.com.au> <20010810104450.F31136@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> With this patch my first oops seems to have gone away.  I'm repeating
> the test again, but dbench'ing 2,4,8,16,32 and then 64 (until disk
> space ran out) worked this time.

Thanks, Tom and Christian.

Yup, it's definitely a bug and the fix will be in 0.9.6 (in fact the way
things are looking at present it'll be the only substantive change in
0.9.6).

If it's possible, could you please also test journalled data mode?

It'd be interesting to sanity test recovery as well, but doing
thorough testing of recovery is hard.  That's why the ext3 patch
places interesting debug/devel code way down inside the IDE device
driver...
