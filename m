Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286221AbRLTMKA>; Thu, 20 Dec 2001 07:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286220AbRLTMJm>; Thu, 20 Dec 2001 07:09:42 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:25609 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S286219AbRLTMJJ>;
	Thu, 20 Dec 2001 07:09:09 -0500
Date: Thu, 20 Dec 2001 14:13:16 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@l>
To: bert hubert <ahu@ds9a.nl>
cc: <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/WANT TO FIX] Equal Cost Multipath Broken in 2.4.x
In-Reply-To: <20011220122927.A12949@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0112201403450.5678-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 20 Dec 2001, bert hubert wrote:

> Your patch does not appear to relate to iproute-20010824. I think I've found

	Hm, it is against iproute2-2.4.7-now-ss010824.tar.gz. Is
iproute-20010824 (what is that?) somehow different?

> the problem, however. I think there has been an API change between 2.2 and
> 2.4. 'ip' compiled under 2.2 will not properly configure ECMP on 2.4!

	May be the effect is different with different compiler ...
and uninitialized stack data. See the entry in RELNOTES:

[010803]
 * If "dev" is not specified in multipath route, ifindex remained
   uninitialized. Grr. Thanks to Kunihiro Ishiguro <kunihiro@zebra.org>.

	It seems the same bug exists for rtnh_flags and rtnh_hops,
at the same place.

> If I recompile tc under 2.4, the problem disappears.

	This is new. IIRC, the other users don't have such success :)

> Regards,
>
> bert

Regards

--
Julian Anastasov <ja@ssi.bg>

