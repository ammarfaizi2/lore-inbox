Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUXdS>; Wed, 21 Feb 2001 18:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRBUXdI>; Wed, 21 Feb 2001 18:33:08 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:17025 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129170AbRBUXcz>;
	Wed, 21 Feb 2001 18:32:55 -0500
Message-ID: <XFMail.20010221153438.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <971i36$180$1@penguin.transmeta.com>
Date: Wed, 21 Feb 2001 15:34:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: <torvalds@transmeta.com (Linus Torvalds)>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Feb-2001 Linus Torvalds wrote:
> In article <20010221023515.6DF8E18C99@oscar.casa.dyndns.org>,
> Ed Tomlinson  <tomlins@cam.org> wrote:
>>
>>The default in reiserfs is now the R5 hash, but you are right that lots of
>>efforts went 
>>into finding this hash.  This includes testing various hashes on real
>>directory 
>>structures to see which one worked best.  R5 won.
> 
> That's interesting.  The R5 hash is easily also the only one of the
> reiser hashes that might be useable for the generic VFS hashing.  It's
> not so different in spirit from the current one, and if you've done the
> work to test it, it's bound to be a lot better.
> 
> (The current VFS name hash is probably _really_ stupid - I think it's
> still my original one, and nobody probably ever even tried to run it
> through any testing.  For example, I bet that using a shift factor of 4
> is really bad, because it evenly divides a byte, which together with the
> xor means that you can really easily generate trivial bad cases). 
> 
> What did you use for a test-case? Real-life directory contents? Did you
> do any worst-case analysis too?

Yep, 4 is not good as a shifting factor. Prime number are the better choice for
this stuff.
The issue to have a good distribution is not only to have a good hashing
function, but also to give this function not correlated data.
Good hashing function for a Domain A may not be so good for a Domain B.




- Davide

