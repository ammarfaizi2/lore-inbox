Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSJUNED>; Mon, 21 Oct 2002 09:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSJUNED>; Mon, 21 Oct 2002 09:04:03 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:58831 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261369AbSJUNEB>;
	Mon, 21 Oct 2002 09:04:01 -0400
Date: Mon, 21 Oct 2002 14:11:37 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Rob Landley <landley@trommello.org>
Cc: nwourms@netscape.net, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.44 - and offline for a week
Message-ID: <20021021131137.GA12708@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rob Landley <landley@trommello.org>, nwourms@netscape.net,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210182117500.12531-100000@penguin.transmeta.com> <aorjq3$3dm$1@main.gmane.org> <200210201749.41625.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210201749.41625.landley@trommello.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 05:49:41PM -0500, Rob Landley wrote:

 > There will always be code that's not ready before the freeze, and that won't 
 > make it in.  If this wasn't the case, there wouldn't be a need for a cutoff 
 > date, would there?  "Oh, development is over, there are no more interesting 
 > new patches anywhere, we can all go home now."  Doesn't happen.

Likewise, there _will_ be /some/ things that go in after the freeze.

- Things that are broken now that absolutely need fixing at all costs
  before the freeze. Thankfully, most of this work seems to be driver
  work. Some subsystems (ISDN, i2o, some of the net protos) need some
  more indepth surgery, but this is imo all valid work that can happen
  post freeze.
- Zero impact features.
  As an example, now that the x86 subarch support is merged, even quite
  large things, like support for Voyager has no impact on anything else
  now. Likewise new filesystems as long as it doesn't require VFS
  changes. (Something the Reiser4 folks seem to have realised).
- "Oops, this is totally broken" features.
  There still seems no concensus on volume management for 2.6
  Leaving existing LVM1 users dead in the water with the reply
  "leave it to vendors to add the dm/evms patch" just doesn't seem
  right. We need *something* for 2.6

AFAIAC, the freeze that happens on Linus return is really just a freeze
on core changes that have knock-on effects on other areas.
Lets worry about getting that right first, and hopefully we won't
have the 2.x.99 "this VM isn't quite right" holy wars yet again.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk

