Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbRGLHYM>; Thu, 12 Jul 2001 03:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbRGLHYC>; Thu, 12 Jul 2001 03:24:02 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:14869 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267446AbRGLHXu>; Thu, 12 Jul 2001 03:23:50 -0400
Date: Thu, 12 Jul 2001 10:23:46 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
Message-ID: <20010712102346.B1503@niksula.cs.hut.fi>
In-Reply-To: <3B4C180E.D3AE1960@idb.hist.no> <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org>; from paul@clubi.ie on Wed, Jul 11, 2001 at 11:12:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 11:12:12PM +0100, you [Paul Jakma] claimed:
> On Wed, 11 Jul 2001, Helge Hafting wrote:
> 
> > That seems completely out of question.  The structures a 2.4.7
> > kernel understands might be insufficient to express the setup
> > a future 2.6.9 kernel is using to do its stuff better.
> 
> however, it might be handy if say you needed to upgrade a stable
> kernel due to a bug fix or security update.
> 
> no?

<clueless>
In that case you might get a way with a simpler approach. Perhaps you could
just replace the changed function(s) with new ones and scan the kernel for
calls to them. Each call should then be changed to point to the new
function. This might work provided the function interfaces don't change
(which might just be true for simple maintenance bug fixes and security
fixes.) It might even be useful for kernel development.

Of course this takes complex locking and the details are propably very
thorny.

I'm not sure if this is possible, IANAKH. But AFAIK this is roughly what
MSVC6.0 edit and continue does for userspace programs. 
</clueless>


-- v --

v@iki.fi
