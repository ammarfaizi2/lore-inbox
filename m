Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbSKUTXv>; Thu, 21 Nov 2002 14:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSKUTXu>; Thu, 21 Nov 2002 14:23:50 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16612 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266976AbSKUTXu>; Thu, 21 Nov 2002 14:23:50 -0500
Date: Thu, 21 Nov 2002 14:32:31 -0500
From: Doug Ledford <dledford@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: David Zaffiro <davzaffiro@netscape.net>, linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <20021121193231.GE14063@redhat.com>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	David Zaffiro <davzaffiro@netscape.net>,
	linux-kernel@vger.kernel.org
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121050607.GA1554@mark.mielke.cc> <3DDCA7C9.9040501@netscape.net> <20021121192045.GE3636@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121192045.GE3636@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 08:20:45PM +0100, Willy Tarreau wrote:
> On Thu, Nov 21, 2002 at 10:30:49AM +0100, David Zaffiro wrote:
> > I use -momit-leaf-frame-pointer for optimization in some own projects, 
> > instead of the "-fomit-frame-pointer". For me, this results in better 
> > codesize/speed compared to both "-fomit-frame-pointer" or no option at 
> > all. Actually gcc-2.95 seems to support this feature as well, but it 
> > never made it into the 2.95 docs... It makes debugging a lot easier too.
> > 
> > So anyone "caring to benchmark", could you please test the 
> > "-momit-leaf-frame-pointer" option for x86 as well...
> 
> Well, I tried on a 2.4.18+patches with gcc 2.95.3. bzImage is :
> 538481 bytes with -fomit-frame-pointer
> 538510 bytes with no particular flag
> 542137 bytes with -momit-leaf-frame-pointer.

These numbers are useless.  Since a change in frame pointer setup changes 
the code sequences in the text section, it is likely to also change 
maximum acheived compression.  Therefore, the size of the compressed 
images can not be compared and result in any useable data, you need to 
compare the size of the uncompressed images.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
