Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVHLTbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVHLTbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVHLTbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:31:13 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:64180 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750804AbVHLTbL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:31:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rhOQ09CyO9udQf00o6hys16YOHCWu++5fYsHGQXBOrU3wq1YSA1djlmnPzfPZ4OaXbKyAa8pK/2m0CTLHllf2X3Z/G4SoXcMaMKsv5j9KwCwjLVG5GxQDyoL85eEkHfQaZTXNXhUg3HI8l8+f64sTUuZ9fUyuq/Rr31NPidiVo4=
Message-ID: <9a87484905081212317ca8c04e@mail.gmail.com>
Date: Fri, 12 Aug 2005 21:31:11 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: rostedt@goodmis.org
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect sa_mask
Cc: Chris Wright <chrisw@osdl.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, gdt@linuxppc.org,
       Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
In-Reply-To: <Pine.LNX.4.58.0508121456570.19908@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1123615983.18332.194.camel@localhost.localdomain>
	 <1123618745.18332.204.camel@localhost.localdomain>
	 <20050809204928.GH7991@shell0.pdx.osdl.net>
	 <1123621223.9553.4.camel@localhost.localdomain>
	 <1123621637.9553.7.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
	 <1123643401.9553.32.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508122036500.16845@yvahk01.tjqt.qr>
	 <20050812184503.GX7762@shell0.pdx.osdl.net>
	 <Pine.LNX.4.58.0508121456570.19908@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 12 Aug 2005, Chris Wright wrote:
> > * Jan Engelhardt (jengelh@linux01.gwdg.de) wrote:
> > > So, if in doubt what is really meant - check which of the two/three/+
> > > different behaviors the users out there favor most.
> >
> > Rather, check what happens in practice on other implementations.  I don't
> > have Solaris, HP-UX, Irix, AIX, etc. boxen at hand, but some folks must.
> >
> 
> I've supplied this before, but I'll send it again.  Attached is a program
> that should show the behavior of the sigaction.  If someone has one of the
> above mentioned boxes, please run this on the box and send back the
> results.
> 
I've got a 4-way pSeries p550 running AIX 5.3 here : 

$ uname -s -M -p -v -r
AIX 3 5 powerpc IBM,9113-550

Output from your program :

$ ./a.out
Unknown return code!!
Unknown return code!!
Unknown return code!!
Unknown return code!!
Unknown return code!!
Unknown return code!!
sa_mask blocks sig


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
