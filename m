Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSF2Egr>; Sat, 29 Jun 2002 00:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSF2Egq>; Sat, 29 Jun 2002 00:36:46 -0400
Received: from fly.hiwaay.net ([208.147.154.56]:50695 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S317189AbSF2Egp>;
	Sat, 29 Jun 2002 00:36:45 -0400
Date: Fri, 28 Jun 2002 23:39:06 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020628233906.A236282@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Ivan Kokshaysky  <ink@jurassic.park.msu.ru> said:
>IIRC, the problem is that BSD and OSF readv/writev(2) manuals
>explicitly talked of 32 bit iov_len, thus allowing the application
>to pass junk in an upper half of the 64 bit word.
>This change broke widely used netscape and acrobat reader,
>please revert it until we have a better solution:

The Tru64 4.0G and 5.1A man pages say that if the sum of the iov_len
values is negative or overflows a 32 bit integer that EINVAL will be
returned, but I think this is only for the backwards compatible
interface where iov_len was defined as int.  It is now defined as size_t
and the rest of the man page never says anything about a 32 bit iov_len
and the upper half being ignored.
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
