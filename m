Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319045AbSIDEWq>; Wed, 4 Sep 2002 00:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319046AbSIDEWq>; Wed, 4 Sep 2002 00:22:46 -0400
Received: from pool-129-44-54-23.ny325.east.verizon.net ([129.44.54.23]:28944
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S319045AbSIDEWq>; Wed, 4 Sep 2002 00:22:46 -0400
Date: Wed, 4 Sep 2002 00:27:09 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, linux-kernel@vger.kernel.org
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Message-ID: <20020904002709.A32318@arizona.localdomain>
References: <200209032148.g83LmWU14950@oboe.it.uc3m.es> <5.1.0.14.2.20020903230434.00ac6c50@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20020903230434.00ac6c50@pop.cus.cam.ac.uk>; from aia21@cantab.net on Tue, Sep 03, 2002 at 11:19:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 11:19:21PM +0100, Anton Altaparmakov wrote:
> At 22:48 03/09/02, Peter T. Breuer wrote:
> >What one has to get rid of is cached metadata state. I'm open to suggestions.
> 
> This is crazy. I don't think you understand what that actually implies. I 
> will give you a real world example below.

It is crazy, but probably achievable.  One could wrap all VFS ops (read,
write, rename, unlink, etc) to do:

distributed_lock()
mount()
op()
umount()
distributed_unlock()

[...]
> I am completely serious, we are talking at least hundreds of milliseconds 
> possibly even several seconds to read that single byte.
> 
> What was that about 50GiB/sec performance again...?

Well, you'll probably get 50B/sec from it..

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
