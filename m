Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWIEN43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWIEN43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWIEN43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:56:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965072AbWIEN42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:56:28 -0400
Subject: Re: [PATCH 07/16] GFS2: Directory handling
From: Steven Whitehouse <swhiteho@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
In-Reply-To: <20060905084334.GA16788@elte.hu>
References: <1157031298.3384.797.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr>
	 <1157445854.3384.965.camel@quoit.chygwyn.com>
	 <20060905084334.GA16788@elte.hu>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 15:02:03 +0100
Message-Id: <1157464923.3384.1014.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 10:43 +0200, Ingo Molnar wrote:
> * Steven Whitehouse <swhiteho@redhat.com> wrote:
[some lines snipped]
> > > >+	if ((char *)cur + cur_rec_len >= bh_end) {
> > > >+		if ((char *)cur + cur_rec_len > bh_end) {
> > > >+			gfs2_consist_inode(dip);
> > > >+			return -EIO;
> > > >+		}
> > > >+		return -ENOENT;
> > > >+	}
> > > 
> > > if((char *)cur + cur_rec_len > bh_end) {
> > > 	gfs2_consist_inode(dip);
> > > 	return -EIO;
> > > } else if((char *)cur + cur_rec_len == bh_end)
> > > 	return -ENOENT;
> > > 
> > ok
> 
> this one is not OK! Firstly, Jan, and i mentioned this before, please 
> stop using 'if(', it is highly inconsistent and against basic taste. We 
> only use this construct for function calls (and macros), not for C 
> statements.

I did use use if "if (" form when I made this change rather than a
direct copy & paste from this. So it is ok I think,

Steve.


