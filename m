Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVGFXOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVGFXOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVGFXMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:12:23 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:36821 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S262563AbVGFXKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:10:02 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
To: Jeremy Laine <jeremy.laine@polytechnique.org>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 07 Jul 2005 01:09:50 +0200
References: <4njei-1Ps-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DqJ1b-0001Li-0t@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Laine <jeremy.laine@polytechnique.org> wrote:

> I keep getting OOPS's when using a Bt878 TV card, I am basically unable to
> watch TV for more than about 20-30mn without my system grinding to a halt. If
> I do not make use of the bttv module, the system is perfectly stable. I saw
> the bttv module is marked as "Orphan" in the MAINTAINERS file which is why I
> am writing straight to the LKML, do not hesitate to correct me if this is
> wrong!
> 
> I have seen suggestions to try without PREEMPT enabled, which I will be doing
> shortly. Any other suggestions to get to the bottom of this problem are most
> welcome!

I've seen similar hehaviour (machine halts) with a BT848 on a VT82C686
board while displaying the picture on a radeon card under X.org 6.8.1.
Heavy HDD IO almost certainly caused soon death (recognizable by heavy
picture distortion), while an idle system lasted one evening. It did not
happen with kernel 2.4 and a NVidia card on XF86.

These errors were caused by memory corruption, the first four bytes of some
pages were overwritten with binary data (which affected some files in the
cache).

Now I've upgraded to X.org 6.8.2 and done a first stress-test (copying
large files from network to local HDD), and I still can post.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
