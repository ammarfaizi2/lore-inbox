Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318899AbSICUSL>; Tue, 3 Sep 2002 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318905AbSICUSL>; Tue, 3 Sep 2002 16:18:11 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:43158 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318899AbSICUSK>;
	Tue, 3 Sep 2002 16:18:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: Large block device patch, part 1 of 9
Date: Tue, 3 Sep 2002 22:25:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Pavel Machek <pavel@suse.cz>,
       Peter Chubb <peter@chubb.wattle.id.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <20020903160414.K21268@redhat.com> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mKEP-0005kf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 22:19, Daniel Phillips wrote:
> On Tuesday 03 September 2002 22:04, Benjamin LaHaise wrote:
> > On Tue, Sep 03, 2002 at 10:02:38PM +0200, Daniel Phillips wrote:
> > > If you must have a clever macro:
> > > 
> > >    #define lli(foo) (long long int) (foo)
> > >    #define llu(foo) (long long unsigned) (foo)
> > > 
> > > The %lli/%llu have to be there in the format string (modulo as-yet-uninvented
> > > printk hackery) so the cast might as well be there as well.
> > 
> > Do you not read the messages in a thread before posting?
> > 
> > 	static inline long long llsect(sector_t sect) { return sect; }
> > 
> > was the suggestion.
> 
> I didn't like it, I thought it was awkward.  This is better:
> 
>    printk("%lli ", llu(sect));

Err, %llu, and big deal.

-- 
Daniel
