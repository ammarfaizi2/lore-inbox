Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271936AbRH3J3b>; Thu, 30 Aug 2001 05:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271841AbRH3J3V>; Thu, 30 Aug 2001 05:29:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18829 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271936AbRH3J3I>;
	Thu, 30 Aug 2001 05:29:08 -0400
Date: Thu, 30 Aug 2001 02:29:17 -0700 (PDT)
Message-Id: <20010830.022917.52165205.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: manik@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: ioctl conflicts
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15cNuP-0000mP-00@the-village.bc.nu>
In-Reply-To: <20010830.013023.94071732.davem@redhat.com>
	<E15cNuP-0000mP-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 30 Aug 2001 10:14:45 +0100 (BST)

   >    Thats fine. ext2 ioctls and video ioctls go to different places
   > Consider sparc64.
   
   If the ioctl translation layer can't handle duplicates it has bigger
   problems than that

How else can the current scheme translate arguments correctly
if the ioctl values are identical?

Let's say that the video info struct is two ints, right?
That would make the two ioctl values in question be identical.

I agree whole-heartedly that the current scheme is flawed, what
really should happen is that the translations occur in the ioctl
handlers themselves, not in some funny sparc port sources.

That is something I will be doing in 2.5.x, for sure.

Later,
David S. Miller
davem@redhat.com
