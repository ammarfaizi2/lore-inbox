Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUBVODU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 09:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUBVODU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 09:03:20 -0500
Received: from mail.aei.ca ([206.123.6.14]:30204 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261286AbUBVODS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 09:03:18 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Large slab cache in 2.6.1
Date: Sun, 22 Feb 2004 09:03:07 -0500
User-Agent: KMail/1.5.93
Cc: Linus Torvalds <torvalds@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
References: <4037FCDA.4060501@matchmail.com> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402220903.08299.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 21, 2004 10:28 pm, Linus Torvalds wrote:
> On Sat, 21 Feb 2004, Chris Wedgwood wrote:
>
> > 
> > Maybe gradual page-cache pressure could shirnk the slab?
>
> 
> What happened to the experiment of having slab pages on the (in)active
> lists and letting them be free'd that way? Didn't somebody already do 
> that? Ed Tomlinson and Craig Kulesa?

You have a good memory.  

We dropped this experiment since there was a lot of latency between the time a 
slab page became freeable and when it was actually freed.  The current 
call back scheme was designed to balance slab preasure and vmscaning.

Ed Tomlinson
 
> That's still something I'd like to try, although that's obviously 2.7.x 
> material, so not useful for rigth now.
> 
> Or did the experiment just never work out well?
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
