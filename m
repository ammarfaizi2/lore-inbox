Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbRGJWHq>; Tue, 10 Jul 2001 18:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbRGJWHg>; Tue, 10 Jul 2001 18:07:36 -0400
Received: from geos.coastside.net ([207.213.212.4]:20911 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267159AbRGJWHd>; Tue, 10 Jul 2001 18:07:33 -0400
Mime-Version: 1.0
Message-Id: <p05100338b7712bd4a6f2@[207.213.214.37]>
In-Reply-To: <200107102149.QAA36879@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200107102149.QAA36879@tomcat.admin.navo.hpc.mil>
Date: Tue, 10 Jul 2001 15:07:11 -0700
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, cw@f00f.org,
        Brian Gerst <bgerst@didntduck.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, ttabi@interactivesi.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:49 PM -0500 2001-07-10, Jesse Pollard wrote:
>  >     A full cache flush would be needed at every entry into the kernel,
>>      including hardware interrupts.  Very poor for performance.
>>
>>  Why would a cache flush be necessary at all? I assume ia32 caches
>>  where physically not virtually mapped?
>
>Because the entire virtual mapping is replaced by that of the kernel.
>This would invalidate the entire cache table. It was also pointed out
>that this would have to be done for every interrupt too.

If the cache were physically indexed and tagged, this would not be 
the case; changes in mapping would be irrelevant. If someone has a 
reference that describes IA-32 cache tags in detail, I'd like to know 
about it.

TLBs are another story, though on some other architectures they're 
not a problem either. UltraSPARC, for example, maps the entire kernel 
with a couple or three reserved TLB entries (at least Solaris does). 
Of course, SPARC has hardware contexts, which are helpful in this 
regard.
-- 
/Jonathan Lundell.
