Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUGCVpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUGCVpX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 17:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUGCVpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 17:45:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7297 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265269AbUGCVpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 17:45:20 -0400
Date: Sat, 3 Jul 2004 23:45:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joel Soete <soete.joel@tiscali.be>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, marcelo.tosatti@cyclades.com
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Message-ID: <20040703214533.GA2121@ucw.cz>
References: <40E6AC41.4050804@tiscali.be> <20040703205621.GA1640@ucw.cz> <40E7278C.8040001@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E7278C.8040001@tiscali.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 09:39:24PM +0000, Joel Soete wrote:

> Very interesting but well I am not enough fluent in C to understand this 
> fine detail :(
> Can you explain me by an example (let say a long*) what would did "((char 
> *) buffer)++;" versus "buffer += sizeof(char);"
> (Don't worry, if don't have time, I will perfectly understand and will 
> experiment by myself)

Ok. Let's assume

	int *buffer;

just for this example.

	((char *) buffer)++;

increments buffer by 1, while

	buffer += sizeof(char);

increments buffer by 4, because an int* is always
increased/decreased by multiples of sizeof(int).

So

	buffer += 2;

would increment the pointer by 8.

Similarly for other pointer types.

> >So just use
> >
> >	buffer++;
> >
> >here, and the intent is then clear.
> >
> Yes ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
