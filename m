Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVHNLYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVHNLYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 07:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVHNLYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 07:24:24 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:14311 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932491AbVHNLYX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 07:24:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W8SBLChkWp/hIOTFk94yiMBYEzCSNxjMd+sb/cEJ1y9obewAbsJThqXBHiml52Yt+8U1K9ImXp1prUtJZtz0OC4m9Y/D0e2LDr9NtX5HPd+FasfNpey+XWUGsFniVEPsq2BCWdJnzpmID+lbi79d80rVTnGlslB7qWMW0rLxouM=
Message-ID: <9a8748490508140424675191ad@mail.gmail.com>
Date: Sun, 14 Aug 2005 13:24:21 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect sa_mask
Cc: Chris Wright <chrisw@osdl.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, gdt@linuxppc.org,
       Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
In-Reply-To: <1123880891.5296.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1123615983.18332.194.camel@localhost.localdomain>
	 <1123621223.9553.4.camel@localhost.localdomain>
	 <1123621637.9553.7.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
	 <1123643401.9553.32.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508122036500.16845@yvahk01.tjqt.qr>
	 <20050812184503.GX7762@shell0.pdx.osdl.net>
	 <Pine.LNX.4.58.0508121456570.19908@localhost.localdomain>
	 <9a87484905081212317ca8c04e@mail.gmail.com>
	 <1123880891.5296.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 2005-08-12 at 21:31 +0200, Jesper Juhl wrote:
> 
> > >
> > I've got a 4-way pSeries p550 running AIX 5.3 here :
> >
> > $ uname -s -M -p -v -r
> > AIX 3 5 powerpc IBM,9113-550
> >
> > Output from your program :
> >
> > $ ./a.out
> > Unknown return code!!
> > Unknown return code!!
> > Unknown return code!!
> > Unknown return code!!
> > Unknown return code!!
> > Unknown return code!!
> > sa_mask blocks sig
> >
> 
> Did you try my updated code (the one with the extra sleep?). Here's
> another version where I output the unknown return code.  Funny that this
> didn't print any other error message. Since the return codes should show
> something else.
> 
> Please try the attached.
> 
With the version you attached I get this :

$ uname -s -M -p -v -r
AIX 3 5 powerpc IBM,9113-550
$ gcc test_signal.c
$ ./a.out
sa_mask blocks other signals
SA_NODEFER does not block other signals
SA_NODEFER does not affect sa_mask
SA_NODEFER and sa_mask blocks sig
!SA_NODEFER blocks sig
SA_NODEFER does not block sig
sa_mask blocks sig


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
