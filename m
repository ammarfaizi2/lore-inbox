Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273638AbRIQOnX>; Mon, 17 Sep 2001 10:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273639AbRIQOnN>; Mon, 17 Sep 2001 10:43:13 -0400
Received: from t2.redhat.com ([199.183.24.243]:4342 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273638AbRIQOnB>; Mon, 17 Sep 2001 10:43:01 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010917120428.A13815@emma1.emma.line.org> 
In-Reply-To: <20010917120428.A13815@emma1.emma.line.org>  <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu> 
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Sep 2001 15:43:16 +0100
Message-ID: <22094.1000737796@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


matthias.andree@stud.uni-dortmund.de said:
>  Well, from a practical point of view two things that would really
> help Linux:

> 1) Be able kill -9 processes from "D" state. 

'D' state means _uninterruptible_ sleep. To be interruptible, we need to
have appropriate cleanup code at the point at which the code sleeps. Often,
parts of the kernel sleep in 'D' state instead of in 'S' state just because
someone's been too lazy to implement the cleanup.

Each one of those bugs needs to be fixed individually - and many need core
changes. Fixing read_inode() so that well-behaved filesystems can deal with
being interrupted during its operation is on the list for 2.5. Others will
be required too, I'm sure.

--
dwmw2


