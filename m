Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSHOVA4>; Thu, 15 Aug 2002 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSHOVA4>; Thu, 15 Aug 2002 17:00:56 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:22946
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S317415AbSHOVAz>; Thu, 15 Aug 2002 17:00:55 -0400
Date: Thu, 15 Aug 2002 14:04:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: henrique <henrique@cyclades.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
Message-ID: <20020815210449.GA26993@opus.bloom.county>
References: <200208151514.51462.henrique@cyclades.com> <20020815182556.GV9642@clusterfs.com> <20020815190336.GN22974@opus.bloom.county> <20020815195933.GW9642@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815195933.GW9642@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 01:59:33PM -0600, Andreas Dilger wrote:
> On Aug 15, 2002  12:03 -0700, Tom Rini wrote:
> > On Thu, Aug 15, 2002 at 12:25:56PM -0600, Andreas Dilger wrote:
> > > Maybe the PPC keyboard/mouse drivers do not add randomness?
> > 
> > Well, how is this set for the i386 ones?  I grepped around and I didn't
> > really see anything, so I'm sort-of confused.
> 
> I think it is something like "add_mouse_entropy" and "add_keyboard_entropy"
> or similar.  If you look at the random.c sources you can find the actual
> function names and work backwards from there.

Ah, thanks.  In that case, no.  It doesn't look like the input-layer USB
keyboards contribute to entropy (but mice do), and I don't think the ADB
ones do.  I'll take a crack at adding this to keyboards monday maybe.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
