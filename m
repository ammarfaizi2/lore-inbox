Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRLLSTL>; Wed, 12 Dec 2001 13:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRLLSTB>; Wed, 12 Dec 2001 13:19:01 -0500
Received: from fungus.teststation.com ([212.32.186.211]:18960 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S281780AbRLLSSx>; Wed, 12 Dec 2001 13:18:53 -0500
Date: Wed, 12 Dec 2001 19:18:48 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Petr Titera <P.Titera@century.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 4GB file size limit on SMBFS
In-Reply-To: <3C175A07.6000505@century.cz>
Message-ID: <Pine.LNX.4.33.0112121900510.4034-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Petr Titera wrote:

> Hello,
> 
> 	I tested patches from Urban Wildmark to give SMBFS LFS support and found, 
> that limit on file size has only moved from 2GB to 4GB. Is this expected 
> behaviour?

I have never tested it vs a NT server with more than 3G of disc, but it's
a 64bit offset so it should be a bit more ... I'll try and dig up a
machine with more space to test with.

It is possible that the readX/writeX SMB is used incorrectly and that
while it does make the low 32 bits be unsigned the top 32 bits are set to
0.

But I have tested it with >4G files on samba servers and that seemed to
work. You did patch smbmount too?

/Urban

