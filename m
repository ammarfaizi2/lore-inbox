Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSFLWgE>; Wed, 12 Jun 2002 18:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317346AbSFLWgD>; Wed, 12 Jun 2002 18:36:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44501 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317345AbSFLWgC>;
	Wed, 12 Jun 2002 18:36:02 -0400
Date: Wed, 12 Jun 2002 15:31:37 -0700 (PDT)
Message-Id: <20020612.153137.28764566.davem@redhat.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, kravetz@us.ibm.com, rml@tech9.net,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] switch_mm()'s desire to run without the rq lock
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0206121551190.10732-100000@elte.hu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yikes!!! I just noticed a problem.

You can't just delete prepare_to_switch(), that is where we do
the register window flush on Sparc and it has the be at that
exact location.

Can you redo your diffs, preserving prepare_to_switch()?
