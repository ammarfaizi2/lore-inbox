Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311519AbSC1Cwo>; Wed, 27 Mar 2002 21:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311547AbSC1Cwe>; Wed, 27 Mar 2002 21:52:34 -0500
Received: from host-8166.digeo.com ([12.110.81.66]:32689 "EHLO
	khem.blackfedora.com") by vger.kernel.org with ESMTP
	id <S311519AbSC1CwX>; Wed, 27 Mar 2002 21:52:23 -0500
To: linux-kernel@vger.kernel.org
Subject: How to tell how much to expect from a fd
From: Mark Atwood <mra@pobox.com>
Date: 27 Mar 2002 18:52:39 -0800
In-Reply-To: <20010804132159.F18108@weta.f00f.org>
Message-ID: <m3663hjte0.fsf_-_@khem.blackfedora.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does there exist a fcntl or some other way to tell how much data is
"ready to be read" from a fd?

I'm doing this thing where I make the fd non-blocking, select on it,
and then read on it into a buffer that I am pregrowing with realloc.

When the high water mark is up to the top of the buffer, I realloc the
buffer to make it bigger.  At present, I'm just adding a constant
value to the buffer size each time I need to do this, but if there was
a way to easily tell how much was "ready to be read" from the fd.

It's not necessary to be exact. If more becomes available between the
time I do this wanted magic and do the read, read's 3rd parameter will
keep me safe, and if it's too low, like if a dup of the fd already
snarfed the data, also no big deal, I'm non-blocking and check the
return value.

So, is this "nice to have" available?


-- 
Mark Atwood   | Well done is better than well said.
mra@pobox.com | http://www.pobox.com/~mra
