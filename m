Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSHJBd7>; Fri, 9 Aug 2002 21:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSHJBd7>; Fri, 9 Aug 2002 21:33:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37764 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316544AbSHJBd7>;
	Fri, 9 Aug 2002 21:33:59 -0400
Date: Fri, 09 Aug 2002 18:24:33 -0700 (PDT)
Message-Id: <20020809.182433.69288385.davem@redhat.com>
To: akpm@zip.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/12] misc fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D54647C.DB6DE08A@zip.com.au>
References: <3D54647C.DB6DE08A@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Fri, 09 Aug 2002 17:55:24 -0700
   
   - `retval' should not be initialised to "~0UL" because that is
     0x00000000ffffffff with 64-bit sector_t.
   
'0' defaults to 'int' on 32-bit systems so ~0 isn't right either.

What I think you really want is "~(sector_t) 0".
