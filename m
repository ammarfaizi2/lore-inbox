Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315701AbSEILUI>; Thu, 9 May 2002 07:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315707AbSEILUH>; Thu, 9 May 2002 07:20:07 -0400
Received: from cpe.atm2-0-1071115.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:49556
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S315701AbSEILUE>; Thu, 9 May 2002 07:20:04 -0400
Message-ID: <3CDA5B63.4000002@fugmann.dhs.org>
Date: Thu, 09 May 2002 13:20:03 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502 Debian/1.0rc1-3
MIME-Version: 1.0
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: khttpd-users@alt.org, linux-kernel@vger.kernel.org
Subject: Re: Appications in kernelspace (was:Tux in main kernel tree?)
In-Reply-To: <3CD5ECEE.E6C0B894@kegel.com><Pine.LNX.4.44.0205061608300.26867-100000@mustard.heime.net> <15574.52864.321544.44124@gargle.gargle.HOWL> <003c01c1f53f$43427c60$94d4870a@office.abanes.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:
> From: "John Stoffel" <stoffel@casc.com>
> 
>>Or maybe we should include kDNS and kftpd as well now?
 >
> Or even (laugh), an NFS server...
> 
Before I begin, I would like to say that I have never tried khttpd or TUX, and
I do not tknow how they are implemented. It has been postulated (and I beleive that)
that tux and khttpd in kernel space outperforms the userspace equivelent.

In my oppinion, application level protocols should not exist in the kernel-space.
Whenever a functionality is implementented in the kernel, people tends to optimizing generic
tings in the kernel for this functionality (at the cost of genericness).
If we take this thought to the extreme, I can see lots of different kernels in the future with
names like: 3.8.23-http, 3.8.22-nfsd, 3.8.56-IE7 etc, and changlogs like:
- backport VM-IE7 changes from 3.8.56-IE7 to 3.8.23-http.

What we end up with is unmaintainable kernel-code, since focus is removed from the generic kernel
to specific kernels.

Alternative:
Since TUX and khttpd does gain extra performance by running in kernel space,
I think that the problem is clear.

	Userspace programs have no change of performing near the harware/theoretic
	optimum.

Lets fix that. The kernel should not be optimized
for a single program, but allow any program to take advantage of some interface.
NFSd might belong to userspace (I dont know - really), but if its significantly faster in kernel
then we need some changes in the kernel API, to allow same speed in userspace if nfsd belongs there.

Conclusion:
Khttpd et. al. does not belong to the kernel.
Adding applications to the kernel moves focus from generic correct implementations to specific optimizations.
Effort should be made to find out why httpd et. al. is faster, and what can be done _genericly_ to allow
near same performance in userspace.

Hope that this starts some thoughts.
Anders Fugmann








