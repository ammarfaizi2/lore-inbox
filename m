Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272003AbRH3JbV>; Thu, 30 Aug 2001 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272009AbRH3JbM>; Thu, 30 Aug 2001 05:31:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21645 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272003AbRH3JbA>;
	Thu, 30 Aug 2001 05:31:00 -0400
Date: Thu, 30 Aug 2001 02:31:03 -0700 (PDT)
Message-Id: <20010830.023103.19782466.davem@redhat.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Newsgroups: lists.linux.kernel
Subject: Re: ioctl conflicts
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <slrn9ortim.352.kraxel@bytesex.org>
In-Reply-To: <20010828145304Z.haba@pdc.kth.se>
	<3B8DEF9D.26F7544D@cisco.com>
	<slrn9ortim.352.kraxel@bytesex.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerd Knorr <kraxel@bytesex.org>
   Date: 30 Aug 2001 08:16:22 GMT

   Manik Raina wrote:
   >  ./include/linux/videodev.h:#define VIDIOCGCAP          
   >  _IOR('v',1,struct video_capability)
   >  ./include/linux/ext2_fs.h:#define  EXT2_IOC_GETVERSION  _IOR('v',1,
   >  long)   
   
   The size of the argument has a different size, so they end up with
   different magic numbers because of that.
   
What if "struct video_capability" were "int[2]"?  Then the values
would be identical.

Later,
David S. Miller
davem@redhat.com
