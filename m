Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289082AbSANVyX>; Mon, 14 Jan 2002 16:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSANVyN>; Mon, 14 Jan 2002 16:54:13 -0500
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:23819 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S289082AbSANVyC>;
	Mon, 14 Jan 2002 16:54:02 -0500
Message-ID: <3C4353F6.1090709@thock.com>
Date: Mon, 14 Jan 2002 15:56:06 -0600
From: Dylan Griffiths <dylang@thock.com>
Reply-To: dylang+kernel@thock.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020111
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 NFS bug (annoying sylmlinx breakage)
In-Reply-To: <3C43447D.9000504@thock.com> <20020114141209.W26688@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Upgrade your kernel before reporting such bugs.  I'm pretty sure it has
> already been fixed.  Something about the NFSv3 calling an inappropriate
> (but similarly named) function in the symlink path.

I've looked at the 2.4.14 nfs fs code as it seemed client side.


         /* We place the length at the beginning of the page,
          * in host byte order, followed by the string.  The
          * XDR response verification will NULL terminate it.
          */


I'm guessing nfs3xdr.c does not have this behaviour the code relies on.  I 
will grab 2.4.17 and see of the code/behaviour is different.

-- 
     www.kuro5hin.org -- technology and culture, from the trenches.
                          -=-=-=-=-=-
Those that give up liberty to obtain safety deserve neither.
  -- Benjamin Franklin
   http://www.zdnet.com/zdnn/stories/news/0,4586,2812463,00.html
   http://slashdot.org/article.pl?sid=01/09/16/1647231
                          -=-=-=-=-=-

