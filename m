Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313731AbSEARqC>; Wed, 1 May 2002 13:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSEARqB>; Wed, 1 May 2002 13:46:01 -0400
Received: from fungus.teststation.com ([212.32.186.211]:51216 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313731AbSEARqA>; Wed, 1 May 2002 13:46:00 -0400
Date: Wed, 1 May 2002 19:44:59 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: "Scott A. Sibert" <kernel@hollins.edu>
cc: <linux-kernel@vger.kernel.org>, vt <vt@vt.fermentas.lt>
Subject: Re: 2.5.11 and smbfs
In-Reply-To: <3CCEF32B.6060807@hollins.edu>
Message-ID: <Pine.LNX.4.33.0205011842001.1885-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002, Scott A. Sibert wrote:

> I can mount other samba shares fine (ie. Samba-2.2.2 from OSX 10.1.4 and 
> Samba-2.2.2 from Tru64 5.1) and the directories look fine.  When I mount 
> a share from a Windows 2000 server I only get the first letter of the 
> entry in the shared folder which, of course, makes no sense and 
> generates errors when just trying to get an "ls" of the share.  The 
> Win2K servers are both regular server and Adv Server, both with SP2 and 
> the latest patches.  The linux machine is running RedHat 7.2 with almost 
> all of the latest updates and 2.5.11 compiled.

The server is returning unicode filenames but smbfs isn't expecting them.

You don't say which samba version your smbmount is from, but I'm guessing
2.2.1/2.2.2. They always negotiate unicode support without knowing if
smbfs supports it or not, which is a bug.

With smbfs unicode support in 2.5 this started to matter for various
reasons. I have thought about "autodetection" and maybe that will be
necessary anyway.

For now, upgrading samba to 2.2.3a should fix this. Let me know if it
doesn't.

/Urban

