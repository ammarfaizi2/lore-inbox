Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSCSTJp>; Tue, 19 Mar 2002 14:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSCSTJg>; Tue, 19 Mar 2002 14:09:36 -0500
Received: from fungus.teststation.com ([212.32.186.211]:35079 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S291620AbSCSTJZ>; Tue, 19 Mar 2002 14:09:25 -0500
Date: Tue, 19 Mar 2002 20:09:15 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.teststation.com
To: SeongTae Yoo <alloying@nownuri.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: file listing problem in smbfs, kernel 2.4.18
In-Reply-To: <3C96B1FB.BFE2C122@nownuri.net>
Message-ID: <Pine.LNX.4.44.0203191959310.27806-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, SeongTae Yoo wrote:

> Urban Widmark wrote:
> > 
> > You could also try the smbfs unicode patch for 2.4.18, and see if that
> > changes anything.
> >     http://www.hojdpunkten.ac.se/054/samba/index.html
> >     (Note the additional samba patch and mount flags needed)
> 
> I tried it just before, but same result.

And you patched samba, enabled unicode with the unicode flag and set the
"codepage" to be unicode?
(I know, it's a bad interface)

> > Do you have trouble with this set of files elsewhere?
> > 
> > If you have more than one server, does it make any difference if you copy
> > the files to some other server?
> 
> I have already tested before the previous posting, but no difference.

Ok, that's good. Should help reproducing this.

> However, when the files are copied to a fat32 partition of w2k server,
> all files listed.

So, windows is being sensitive ...


> If you need some other tests, I will do it.

Since the unicode test gave the same results it might be useful to compare
how smbfs does the file listing with how a windows box requests. One way
to do that is to get a network trace of both and then compare them.

It's not really a test and if I can reproduce this I could do it myself.
Give me a day or so ...

If you want to do this, go to www.ethereal.com and get the latest version.
It has a nice gtk interface and it will decode most of the common SMB
requests for you.
(You may want to limit the trace of smbfs to port 139, win2k may also use 
 445)

/Urban

