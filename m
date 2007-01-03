Return-Path: <linux-kernel-owner+w=401wt.eu-S1751084AbXACTRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbXACTRj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXACTRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:17:39 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:45383 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbXACTRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:17:35 -0500
Date: Wed, 3 Jan 2007 20:17:34 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Pavel Machek <pavel@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
In-Reply-To: <20070103185815.GA2182@janus>
Message-ID: <Pine.LNX.4.64.0701032009140.6871@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <20061229100223.GF3955@ucw.cz> <Pine.LNX.4.64.0701012333380.5162@artax.karlin.mff.cuni.cz>
 <20070101235320.GS8104@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0701020055580.32128@artax.karlin.mff.cuni.cz>
 <20070103185815.GA2182@janus>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2007, Frank van Maarseveen wrote:

> On Tue, Jan 02, 2007 at 01:04:06AM +0100, Mikulas Patocka wrote:
>>
>> I didn't hardlink directories, I just patched stat, lstat and fstat to
>> always return st_ino == 0 --- and I've seen those failures. These failures
>> are going to happen on non-POSIX filesystems in real world too, very
>> rarely.
>
> I don't want to spoil your day but testing with st_ino==0 is a bad choice
> because it is a special number. Anyway, one can only find breakage,
> not prove that all the other programs handle this correctly so this is
> kind of pointless.
>
> On any decent filesystem st_ino should uniquely identify an object and
> reliably provide hardlink information. The UNIX world has relied upon this
> for decades. A filesystem with st_ino collisions without being hardlinked
> (or the other way around) needs a fix.

... and that's the problem --- the UNIX world specified something that 
isn't implementable in real world.

You can take a closed box and say "this is POSIX cerified" --- but how 
useful such box could be, if you can't access CDs, diskettes and USB 
sticks with it?

Mikulas
