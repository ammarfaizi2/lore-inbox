Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281535AbRKMGYa>; Tue, 13 Nov 2001 01:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281539AbRKMGYU>; Tue, 13 Nov 2001 01:24:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11395 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281535AbRKMGYC>;
	Tue, 13 Nov 2001 01:24:02 -0500
Date: Mon, 12 Nov 2001 22:23:48 -0800 (PST)
Message-Id: <20011112.222348.102614983.davem@redhat.com>
To: kaos@ocs.com.au
Cc: neilb@cse.unsw.edu.au, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <12682.1005632186@kao2.melbourne.sgi.com>
In-Reply-To: <20011112.220341.54186374.davem@redhat.com>
	<12682.1005632186@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Tue, 13 Nov 2001 17:16:26 +1100
   
   That breaks objects which have other __section__(".data.exit") info
   which is not marked const.  I put a comment just above that change...
   
Then change the other definition of that macro to
_NOT_ be const, and then fixup each and every driver
to drop the const directive in their table declaration.

As it stands the two version of that macro are totally
inconsistent.
