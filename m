Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318886AbSICTzv>; Tue, 3 Sep 2002 15:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318887AbSICTzv>; Tue, 3 Sep 2002 15:55:51 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:25238 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318886AbSICTzu>;
	Tue, 3 Sep 2002 15:55:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: Large block device patch, part 1 of 9
Date: Tue, 3 Sep 2002 22:02:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Pavel Machek <pavel@suse.cz>,
       Peter Chubb <peter@chubb.wattle.id.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <E17mJZh-0005jw-00@starship> <20020903155045.J21268@redhat.com>
In-Reply-To: <20020903155045.J21268@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mJsl-0005k6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 21:50, Benjamin LaHaise wrote:
> On Tue, Sep 03, 2002 at 09:42:56PM +0200, Daniel Phillips wrote:
> > and I expect it will be this time too.  It's just a printk!  Who cares if it
> > wastes a few bytes.  It's even conceivable that if we use this idiom heavily
> > enough, some gcc boffin will take the time to optimize away the useless
> > conversions.
> 
> The issue of casting was never successfully treated by any of the approaches 
> that were presented, except by Neil's llsect() function.  It's shorter than 
> (long long)sect and has type safety, so let's just use it.

If you must have a clever macro:

   #define lli(foo) (long long int) (foo)
   #define llu(foo) (long long unsigned) (foo)

The %lli/%llu have to be there in the format string (modulo as-yet-uninvented
printk hackery) so the cast might as well be there as well.

-- 
Daniel
