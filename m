Return-Path: <linux-kernel-owner+w=401wt.eu-S1030255AbXADW76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbXADW76 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbXADW75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:59:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42889 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030181AbXADW74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:59:56 -0500
Date: Thu, 4 Jan 2007 23:59:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070104225929.GC8243@elf.ucw.cz>
References: <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu> <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > High probability is all you have.  Cosmic radiation hitting your
> > > computer will more likly cause problems, than colliding 64bit inode
> > > numbers ;)
> > 
> > Some of us have machines designed to cope with cosmic rays, and would be
> > unimpressed with a decrease in reliability.
> 
> With the suggested samefile() interface you'd get a failure with just
> about 100% reliability for any application which needs to compare a
> more than a few files.  The fact is open files are _very_ expensive,
> no wonder they are limited in various ways.
> 
> What should 'tar' do when it runs out of open files, while searching
> for hardlinks?  Should it just give up?  Then the samefile() interface
> would be _less_ reliable than the st_ino one by a significant margin.

You need at most two simultenaously open files for examining any
number of hardlinks. So yes, you can make it reliable.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
