Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSIEFjg>; Thu, 5 Sep 2002 01:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSIEFjf>; Thu, 5 Sep 2002 01:39:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21733 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316897AbSIEFjf>;
	Thu, 5 Sep 2002 01:39:35 -0400
Date: Wed, 04 Sep 2002 22:36:51 -0700 (PDT)
Message-Id: <20020904.223651.79770866.davem@redhat.com>
To: szepe@pinerecords.com
Cc: mason@suse.com, reiser@namesys.com, shaggy@austin.ibm.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905054008.GH24323@louise.pinerecords.com>
References: <3D76A6FF.509@namesys.com>
	<1031186951.1684.205.camel@tiny>
	<20020905054008.GH24323@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Thu, 5 Sep 2002 07:40:08 +0200

   > Our disk format has link counts > 32k
   
   Does the internal reiserfs nlink value translate directly
   to what stat() puts in st_nlink?
   
It really doesn't matter.  Even if you have some huge value that can't
be represented in st_nlink, you can report to the user that st_nlink
is NLINK_MAX.

This is one possible solution to this whole problem.
