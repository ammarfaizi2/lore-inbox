Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271349AbRIAUsL>; Sat, 1 Sep 2001 16:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271368AbRIAUsB>; Sat, 1 Sep 2001 16:48:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:55981 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271349AbRIAUru>; Sat, 1 Sep 2001 16:47:50 -0400
Message-ID: <3B914805.F9883E5E@vnet.ibm.com>
Date: Sat, 01 Sep 2001 15:41:41 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <_deepfire@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: is bzImage container large enough?
In-Reply-To: <22500.999376181@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keith Owens wrote:

> On Sat, 1 Sep 2001 16:28:06 +0000 (UTC),
> Samium Gromoff <_deepfire@mail.ru> wrote:
> >      If one wanting to turn on virtually every kernel CONFIG_* option
> >  in order to check if the kernel compiles and then report possible
> >  gcc errors to lkml, will the resulting kernel fit the bzImage format?
>
> No, it is far too big.

We just "fixed" this sort of problem for ppc64 the other day. Course we
don't use bzImages but rather zImages but none the less it was still
anoying since we can boot zImages over the network and
of course that makes it quite reasonable to blow past the 1.44
floppy limitation. The bug we fixed was that an uncompressed
kernel could only be up to 4 meg in size, if it was larger, at
uncompression time you'd just lose everything past the 4M mark.
Todd Inglett raised the limit to 8 meg for us, and that's a mighty
large penguin....

Regards,

Tom

--
Tom Gall - PPC64 Code Monkey  "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc


