Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRIAIzr>; Sat, 1 Sep 2001 04:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270178AbRIAIzh>; Sat, 1 Sep 2001 04:55:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45450 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270174AbRIAIza>;
	Sat, 1 Sep 2001 04:55:30 -0400
Date: Sat, 01 Sep 2001 01:55:36 -0700 (PDT)
Message-Id: <20010901.015536.61333988.davem@redhat.com>
To: paulus@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15248.40412.665276.271570@cargo.ozlabs.ibm.com>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
	<20010831.154550.70219421.davem@redhat.com>
	<15248.40412.665276.271570@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This still is a no-go.  You updated the header file, but what about
the symbol names in arch/sparc64/lib/blockops.S and the module
exports in arch/sparc64/kernel/sparc64_ksyms.c  There is no way this
thing will build.

Please, always apply a:

egrep {copy,clear}_user_page `find arch/ include/ -type f`

pass when doing these kinds of platform API changes.

Later,
David S. Miller
davem@redhat.com
