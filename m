Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSIEFsR>; Thu, 5 Sep 2002 01:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSIEFsR>; Thu, 5 Sep 2002 01:48:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30693 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316996AbSIEFsR>;
	Thu, 5 Sep 2002 01:48:17 -0400
Date: Wed, 04 Sep 2002 22:45:31 -0700 (PDT)
Message-Id: <20020904.224531.118542066.davem@redhat.com>
To: szepe@pinerecords.com
Cc: mason@suse.com, reiser@namesys.com, shaggy@austin.ibm.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905054858.GI24323@louise.pinerecords.com>
References: <20020905054008.GH24323@louise.pinerecords.com>
	<20020904.223651.79770866.davem@redhat.com>
	<20020905054858.GI24323@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Thu, 5 Sep 2002 07:48:58 +0200
   
   And a pretty straightforward one, too. Convert the internal reiserfs
   link stuff to an unsigned short, find NLINK_MAX using the code I posted
   last night (or maybe simply grab it from userspace includes) and add
   a check to your stat() code to return NLINK_MAX if necessary.
   
Whose stat() code?  These go straight to userspace via normal
syscalls.
   
It has to be done generically, in the VFS or reiserfs.
