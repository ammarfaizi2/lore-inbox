Return-Path: <linux-kernel-owner+w=401wt.eu-S1751037AbXACSgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXACSgv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbXACSgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:36:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:52265 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751030AbXACSgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:36:50 -0500
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC][PATCH] use cycle_t instead of u64 in struct time_interpolator
Date: Wed, 3 Jan 2007 19:36:36 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
References: <200701022233.25697.deller@gmx.de> <Pine.LNX.4.64.0701030942160.7909@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701030942160.7909@schroedinger.engr.sgi.com>
X-Face: *4/{KL3=jWs!v\UO#3e7~Vb1~CL@oP'~|*/M$!9`tb2[;fY@)WscF2iV7`,a$141g'o,=?utf-8?q?7X=0A=09=3FBt1Wb=3AL7K6z-?=<?-+-13|S_ixrq58*E`)ZkSe~NSI?u=89G'J<n]7\?[)LCCBZc}~[j(=?utf-8?q?e=7D=0A=09=60-QV=7B=23=25=26=5B=3F=5EfAke6t8QbP=3Bb=27XB?=,ZU84HeThMrO(@/K.`jxq9P({V(AzezCKMxk\F2^p^+"=?utf-8?q?=0A=09=5B?="ppalbA!zy-l)^Qa3*u/Z-1W3,o?2fes2_d\u=1\E9N+~Qo
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701031936.36423.deller@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 3 2007, Christoph Lameter wrote:
> On Tue, 2 Jan 2007, Helge Deller wrote:
> 
> > As far as I could see, this patch does not change anything for the 
> > existing architectures which use this framework (IA64 and SPARC64), 
> > since "cycles_t" is defined there as unsigned 64bit-integer anyway 
> > (which then makes this patch a no-change for them).
> 
> The 64bit nature of some entities was so far necessary to get the 
> proper accuracy of interpolation. Maybe it can be made to work with 32 bit 
> entities. The macro GET_TI_SECS must work correctly and the less bits are 
> specified in shift the less self-tuning accuracy you will get.

Yes, it was easily possible to make it 32bit-ready without loosing the accuracy.

Nevertheless, in the meantime John Stultz pointed me to the CONFIG_GENERIC_TIME framework,  and I implemented it that way:
http://git.parisc-linux.org/?p=linux-2.6.git;a=commit;h=b6de83b58b8b07f057deacdef8a95b6c32d1c4e6
http://git.parisc-linux.org/?p=linux-2.6.git;a=commit;h=f70a979c843e4610edfb2a316648fe8ae8718f69

Thus please ignore my original patch proposal. It's not needed any more...

Thanks,
Helge

