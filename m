Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbRGZBfY>; Wed, 25 Jul 2001 21:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbRGZBfP>; Wed, 25 Jul 2001 21:35:15 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:53920 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267490AbRGZBfI>; Wed, 25 Jul 2001 21:35:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Kees Cook <linux-kernel@outflux.net>
Date: Thu, 26 Jul 2001 11:34:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15199.29634.651339.401536@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add "autorun" interface to md
In-Reply-To: message from Kees Cook on Wednesday July 25
In-Reply-To: <20010724112451.B6287@cpoint.net>
	<20010725081342.J6287@cpoint.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wednesday July 25, linux-kernel@outflux.net wrote:
> 
> Any one out there working on the "md" driver?
> 

Yes,  I'm doing a fair bit. 
If you are interested in the "md" driver, you really should join
  linux-raid@vger.kernel.org

With reguard to your patch,  the short answer is that you really don't
want to do that (or atleast, I don't want to, and I think that you
should agree with me:-)

autorun/autodetect just doesn't belong in the kernel.  It should be
done in user space.  The only time the kernel should assemble a raid
array itself is for the root device, and this is best done with
  md=0,/dev/whatever,etc

If I could start with a clean slate, I would rip out the autodetect
stuff completely.  But lots of people are depending on it so I cannot.

It is true that there is not currently any userlevel tool which does
the equivalent of autodetect, but there will be soon.  It has been
mentioned on linux-raid and an announcement will go there when it is
ready for wider testing.

You can find the current pre-release at:
  http://www.cse.unsw.edu.au/~neilb/source/mdctl/

NeilBrown
