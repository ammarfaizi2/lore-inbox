Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTLDCaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 21:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTLDCaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 21:30:25 -0500
Received: from desire.actrix.co.nz ([203.96.16.164]:14052 "EHLO
	desire.actrix.co.nz") by vger.kernel.org with ESMTP id S261522AbTLDCaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 21:30:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Charles Manning <manningc2@actrix.gen.nz>
Reply-To: manningc2@actrix.gen.nz
To: Linus Torvalds <torvalds@osdl.org>,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: partially encrypted filesystem
Date: Thu, 4 Dec 2003 15:37:05 +1300
X-Mailer: KMail [version 1.3.1]
Cc: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20031204023019.3466017340@desire.actrix.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ** NOTE NOTE NOTE **
>
> If you don't need to mmap() the files, writing becomes much easier.
> Because then you can make rules like "the page cache accesses always
> happen with the page locked", and then the encryption layer can do the
> encryption in-place.
>
> So it is potentially much easier to make encrypted files a special case,
> and disallow mmap on them, and also disallow concurrent read/write on
> encrypted files. This may be acceptable for a lot of uses (most programs
> still work without mmap - but you won't be able to encrypt demand-loaded
> binaries, for example).
>

Is there a useful half-way point here: how about supporting mmap reading but 
not mmap writing. JFFS2, which incidentally also does compression, does this 
to allow execution of binaries.

-- Charles
