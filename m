Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312735AbSCZVQM>; Tue, 26 Mar 2002 16:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312738AbSCZVQD>; Tue, 26 Mar 2002 16:16:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:44477 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312736AbSCZVPs>;
	Tue, 26 Mar 2002 16:15:48 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 21:15:44 GMT
Message-Id: <UTC200203262115.VAA429771.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, balbir_soni@yahoo.com, jholly@cup.hp.com,
        plars@austin.ibm.com
Subject: Re: readv() return and errno
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From jholly@cup.hp.com Tue Mar 26 18:13:40 2002

    Doesn't seem confusing at all.

    RETURN VALUE
           On  success  readv  returns  the number of bytes read.  On
           success writev returns the number of  bytes  written.   On
           error, -1 is returned, and errno is set appropriately.

    ERRORS
           EINVAL An  invalid  argument was given. For instance count
                  might be greater than MAX_IOVEC, or zero.  fd could
                  also  be  attached to an object  which  is  unsuit-
                  able  for  reading  (for  readv)  or  writing  (for
                  writev).

    I don't see much in the way of waffle words. If count is greater than
    MAX_IOVEC or zero you get EINVAL.

Yes, without hesitation you choose the wrong interpretation.
That is why I explained in so much detail what the right
interpretation is. Since you perhaps still do not understand,
let me reiterate:

The above ERRORS section says: In case this call returns EINVAL
one of the possible reasons is that an invalid argument was given.
There do exist Unix-like systems (not necessarily Linux) that
consider a zero count invalid.

Andries
