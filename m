Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318818AbSICTqN>; Tue, 3 Sep 2002 15:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318879AbSICTqN>; Tue, 3 Sep 2002 15:46:13 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:7407 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318818AbSICTqM>; Tue, 3 Sep 2002 15:46:12 -0400
Date: Tue, 3 Sep 2002 15:50:45 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Pavel Machek <pavel@suse.cz>,
       Peter Chubb <peter@chubb.wattle.id.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20020903155045.J21268@redhat.com>
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <20020827185833.B26573@redhat.com> <15732.34929.657481.777572@notabene.cse.unsw.edu.au> <E17mJZh-0005jw-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17mJZh-0005jw-00@starship>; from phillips@arcor.de on Tue, Sep 03, 2002 at 09:42:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 09:42:56PM +0200, Daniel Phillips wrote:
> and I expect it will be this time too.  It's just a printk!  Who cares if it
> wastes a few bytes.  It's even conceivable that if we use this idiom heavily
> enough, some gcc boffin will take the time to optimize away the useless
> conversions.

The issue of casting was never successfully treated by any of the approaches 
that were presented, except by Neil's llsect() function.  It's shorter than 
(long long)sect and has type safety, so let's just use it.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
