Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSEQJs0>; Fri, 17 May 2002 05:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315537AbSEQJsZ>; Fri, 17 May 2002 05:48:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41626 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315536AbSEQJsY>;
	Fri, 17 May 2002 05:48:24 -0400
Date: Fri, 17 May 2002 02:35:06 -0700 (PDT)
Message-Id: <20020517.023506.105129697.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E178eMm-0000NO-00@wagner.rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Fri, 17 May 2002 19:49:40 +1000
   
   Sorry I wasn't clear: I'm saying *replace*, not add,

I don't understand what you are proposing then.  There are some
instances that do want to know how many bytes did make it before
the -EFAULT event.

You have to add a new version of the interface to handle both
the case that cares about the length copied successfully and
the case that only cares about -EFAULT vs. !-EFAULT
