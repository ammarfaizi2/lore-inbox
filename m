Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRE3Pis>; Wed, 30 May 2001 11:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbRE3Pii>; Wed, 30 May 2001 11:38:38 -0400
Received: from t2.redhat.com ([199.183.24.243]:4084 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261410AbRE3Pi0>; Wed, 30 May 2001 11:38:26 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <593aht81ed3p199mr0l1m896d32bgr6qnv@4ax.com> 
In-Reply-To: <593aht81ed3p199mr0l1m896d32bgr6qnv@4ax.com>  <fa.f4liqpv.6lq2r7@ifi.uio.no> <CA256A5B.00548719.00@d73mta01.au.ibm.com> <fa.e3ea6bv.t0ceia@ifi.uio.no> 
To: William Waddington <csbwaddington@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: query regarding 'map_user_kiobuf' 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 16:37:50 +0100
Message-ID: <14179.991237070@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


csbwaddington@att.net said:
>  I have a couple of user DMA drivers up and running, but in light of
> your comment, I am not so sure. 

I'm sorry, it seems I lied. Although map_user_kiobuf in 2.2 used to lock 
the pages, apparently that's no longer necessary. You just need to make 
sure they're marked dirty before you unmap the kiobuf.

--
dwmw2


