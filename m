Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135626AbRDSLgC>; Thu, 19 Apr 2001 07:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135627AbRDSLfm>; Thu, 19 Apr 2001 07:35:42 -0400
Received: from nef.ens.fr ([129.199.96.32]:30725 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S135626AbRDSLfk>;
	Thu, 19 Apr 2001 07:35:40 -0400
Date: Thu, 19 Apr 2001 13:35:38 +0200
From: =?iso-8859-1?Q?=C9ric_Brunet?= <ebrunet@quatramaran.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Children first in fork
Message-ID: <20010419133538.A28654@quatramaran.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have read on lwn.net that the patch that makes children run first after
a fork has been integrated in the latest pre-kernel.

I am a little bit concerned by that, as I have begun to write a program
that monitors process using ptrace. The difficulty is to ptrace-attach
the child in a fork before it can do anything unmonitored. When the
parent runs first, the return from the fork system called is trapped by
the monitor program which has enough time to ptrace-attach the child. If
the child runs first, it is not even remotely the case anymore.

I understand that performance is more important that the possibility to
ptrace across forks, but I still think that there should be a way to
attach the children of a ptraced-process. Is there currently a way to
achieve this in the kernel that I am not aware of ?

Éric Brunet
