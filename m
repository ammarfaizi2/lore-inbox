Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVJFPnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVJFPnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVJFPnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:43:18 -0400
Received: from 30.Red-80-36-33.staticIP.rima-tde.net ([80.36.33.30]:28327 "EHLO
	linalco.com") by vger.kernel.org with ESMTP id S1751102AbVJFPnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:43:17 -0400
Date: Thu, 6 Oct 2005 17:41:40 +0200
From: Ragnar Hojland Espinosa <ragnar.hojland@linalco.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Marc Perkel <marc@perkel.com>, Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006154140.GA4833@linalco.com>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005152447.GD10538@lkcl.net> <20051005153006.GD8011@csclub.uwaterloo.ca> <20051005154226.GI10538@lkcl.net> <20051005155516.GF7949@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005155516.GF7949@csclub.uwaterloo.ca>
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 11:55:16AM -0400, Lennart Sorensen wrote:
> On Wed, Oct 05, 2005 at 04:42:26PM +0100, Luke Kenneth Casson Leighton wrote:
> >  i have no idea.  as a user, i just did rm -fr /tmp/* (sorry - not
> >  rm -fr /tmp) and it worked.
> > 
> >  as a user.
> > 
> >  not root.
> 
> Then some admin didn't qualify for root having apparently removed the t
> bit from /tmp making it a world writeable dir.  Ouch.
> 
> >  they weren't dumb enough to give it to me.
> 
> But they made /tmp world writeable it seems.  Impresive. :)

Silly accidents like that happen.  A lazy tarballer in action:

# ls -ld foo
drwxr-xr-x  2 root   root  48 Oct  6 17:34 foo
# cd foo
# tar cf ../foo.tar .

And too sleepy root who blindly untars to /tmp

# ls -ld tmp
drwxrwxrwt  2 root   root  48 Oct  6 17:34 tmp
# tar xf foo.tar
# ls -ld tmp
drwxr-xr-x  2 root   root     72 Oct  6 17:36 tmp

woops.

-- 
Ragnar Hojland - Project Manager
Linalco "Specialists in Linux and Free Software"
http://www.linalco.com  Tel: +34-91-4561700
