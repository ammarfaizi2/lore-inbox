Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314150AbSDLVrF>; Fri, 12 Apr 2002 17:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314151AbSDLVrE>; Fri, 12 Apr 2002 17:47:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42980 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314150AbSDLVrE>;
	Fri, 12 Apr 2002 17:47:04 -0400
Date: Fri, 12 Apr 2002 14:39:34 -0700 (PDT)
Message-Id: <20020412.143934.33012005.davem@redhat.com>
To: ak@suse.de
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020412143559.A25386@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 12 Apr 2002 14:35:59 +0200

   On Fri, Apr 12, 2002 at 09:30:11PM +0900, Hirokazu Takahashi wrote:
   > I analysis this situation, read systemcall doesn't lock anything
   >  -- no page lock, no semaphore lock --  while someone truncates
   > files partially. 
   > It will often happens in case of pagefault in copy_user() to
   > copy file data to user space.
    
   I don't see it as a big problem and would just leave it as it is
   (for NFS and local) 

I agree with Andi.  You can basically throw away my whole argument
about this.  Applications that require synchonization between the
writer of file contents and reader of file contents must do some
kind of locking amongst themselves at user level.
