Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSIAMSH>; Sun, 1 Sep 2002 08:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSIAMSH>; Sun, 1 Sep 2002 08:18:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30914 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316853AbSIAMSH>;
	Sun, 1 Sep 2002 08:18:07 -0400
Date: Sun, 01 Sep 2002 05:16:11 -0700 (PDT)
Message-Id: <20020901.051611.85397564.davem@redhat.com>
To: szepe@pinerecords.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020901121053.GA7325@louise.pinerecords.com>
References: <20020901113741.GM32122@louise.pinerecords.com>
	<20020901.043512.51698754.davem@redhat.com>
	<20020901121053.GA7325@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sun, 1 Sep 2002 14:10:53 +0200

   > Let's keep the sparc atomic_read() how it is so more bugs
   > like this can be found.
   
   I don't know, though... scratching my head here -- Is GCC actually
   able to distinguish between 'const int *a' and 'int const *a'?
   
No I don't mean this in a "C" sense, I mean conceptually that marking
an object const which has members which are volatile and updated
asynchronously makes zero sense.
