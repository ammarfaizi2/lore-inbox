Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVCVJlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVCVJlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVCVJlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:41:37 -0500
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43]:57869
	"EHLO fluffy.bear-cave.org.uk") by vger.kernel.org with ESMTP
	id S262595AbVCVJl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:41:29 -0500
Message-ID: <XFMail.20050322094106.jim.hague@acm.org>
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
Date: Tue, 22 Mar 2005 09:41:06 -0000 (GMT)
X-Face: #e_3/{lz7I8PY]c%cr|7\sfMTD|Ar*F0e~U%InA`aG0^}hG2hT`H9Lr=R?Nl,9-cP)_o}BN
 DAB"m_&V"ntfjv%6q30^]Q\<YL5[mLMi"X_qm`eA^AA?-SC>NTny77`@0?P@FpO{b*dM409XvO$kmP
 [~W=-Cm~|#49QE;@'K}LGK}??aD=>|x=B:n6"`}!9FIrtfOx%`hTC5#VFORluPrtN_#-_6b,Cu^NF|
 :D=97AFz\(mw=K
Organization: The Bear Cave
From: Jim Hague <jim.hague@acm.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Mar-2005 Guennadi Liakhovetski wrote:
> On Mon, 21 Mar 2005, Andrew Morton wrote:
>> Guennadi, could you please confirm that
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.
>> 12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
>> 
>> fixes this one?
> 
> As discussed with Jim on linux-fbdev-devel this patch fixes the vt / X 
> switching problem. We still don't know why starting with 2.4.11 I have to 
> switch CONFIG_FB_PM2_FIFO_DISCONNECT off to restore colours / images.
> [...]
> I traced this breakage down to the patch to 
> pm2fb.c after 2.6.10-rc2. Jim wanted to try to reproduce this problem with 
> my fb-geometry / colour settings, but I haven't heard from him since then, 

FIrst off, so we're all clear, the problem with vt/X switching was definitely a
pm2fb bug exposed by chages in fbcon, and is definitely fixed by the above
patch. Please apply.

As to Guennadi's problem with colours and images, I've been trying to
reproduce locally without success, hence silence. My pm2fb-on-Sparc
correspondent hasn't seen this either, and I've had no other reports.

I have one possible clue, which I'll pursue with Guennadi off-list.

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.
