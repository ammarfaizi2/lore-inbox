Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135959AbRDTQUO>; Fri, 20 Apr 2001 12:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135960AbRDTQUE>; Fri, 20 Apr 2001 12:20:04 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:8682 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135959AbRDTQTy>;
	Fri, 20 Apr 2001 12:19:54 -0400
Message-ID: <3AE061A5.FDB4CD5C@mandrakesoft.com>
Date: Fri, 20 Apr 2001 12:19:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roberto Nibali <ratz@tac.ch>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104200301380.5165-100000@age.cs.columbia.edu> <3AE05F5A.7942C824@tac.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
> 
> > This was a special case, which btw had nothing to do with the starfire
> > driver itself. The user needed to support more than 8 eth ports, which
> > 2.2 complains about, and more than 16 eth ports, which 2.2 simply doesn't
> > allow without further changes.
> 
> I made the changes and I was able to load 4 quadboards, 2 3com cards and
> 1 eepro100 (onboard) and I did some tests and it works fine. However the
> starfire driver seems not to initialize more then 4 quadboards. I put in
> 5 and he doesn't initialize it and the others don't work although they
> get initialized.

If all five show up in 'lspci', then starfire driver should be able to
register all five.  [if it doesn't, it is probably a starfire bug]

If only four show up in lspci, that sounds more like a PCI core problem

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
