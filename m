Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752308AbWCFJGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbWCFJGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbWCFJGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:06:53 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:63631 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1752308AbWCFJGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:06:52 -0500
Message-ID: <440BFBA1.8030302@aitel.hist.no>
Date: Mon, 06 Mar 2006 10:06:41 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety
References: <32518.1141401780@warthog.cambridge.redhat.com>  <1146.1141404346@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>(Actually, I think one special case of non-temporal instruction is the 
>"repeat movs/stos" thing: I think you should _not_ use a "repeat stos" to 
>unlock a spinlock, exactly because those stores are not ordered wrt each 
>other, and they can bypass the write queue. Of course, doing that would 
>be insane anyway, so no harm done ;^).
>  
>
oops - there  goes the "unlock an array of spinlocks
in a single instruction" idea. :-)

Helge Hafting

