Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUDJAuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 20:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUDJAuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 20:50:44 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:38358 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261635AbUDJAun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 20:50:43 -0400
Date: Fri, 9 Apr 2004 20:50:42 -0400
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Miles Bader <miles@gnu.org>, Chris Meadors <clubneon@hereintown.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: initramfs howto?
Message-ID: <20040410005042.GF7497@fencepost>
References: <1081451826.238.23.camel@clubneon.priv.hereintown.net> <1081490209.28834.19.camel@camp4.serpentine.com> <buo4qrt4pga.fsf@mcspd15.ucom.lsi.nec.co.jp> <1081531299.19918.13.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081531299.19918.13.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 10:21:39AM -0700, Bryan O'Sullivan wrote:
> > If so, it'd be nice if it checked for some other name than /init
> > (e.g. /sbin/init) -- there's too much crap in / already.
> 
> I'm agnostic.  It's a two-line patch.  I don't care if it's called
> /spam/fandango/wubble, so long as the brave souls who are trying out
> initramfs don't keep stumbling over the same problem again and again :-)

Indeed; I just wanna raise the point before people start actually using /init
in large numbers...

I wonder if you could move the bulk of stuff (the console open, the calls to
run_init_proces) that happens after prepare_namespace into a separate
function and attempt to call it both before and after prepare_namespace; the
problem seems to be the unlock_kernel &c., which I gather must be done after
prepare_namespace?

-Miles
-- 
I'm beginning to think that life is just one long Yoko Ono album; no rhyme
or reason, just a lot of incoherent shrieks and then it's over.  --Ian Wolff
