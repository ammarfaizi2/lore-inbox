Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312852AbSCZXwK>; Tue, 26 Mar 2002 18:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312860AbSCZXvx>; Tue, 26 Mar 2002 18:51:53 -0500
Received: from hera.cwi.nl ([192.16.191.8]:43732 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312855AbSCZXve>;
	Tue, 26 Mar 2002 18:51:34 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 23:50:42 GMT
Message-Id: <UTC200203262350.XAA421357.aeb@cwi.nl>
To: alan@lxorguk.ukuu.org.uk, cyeoh@samba.org
Subject: Re: [PATCH] fcntl returns wrong error code
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com, trivial@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > When fcntl(fd, F_DUPFD, b) is called where 'b' is greater than the
    > maximum allowable value EINVAL should be returned. From POSIX:
    > 
    > "[EINVAL] The cmd argument is invalid, or the cmd argument is F_DUPFD and
    > arg is negative or greater than or equal to {OPEN_MAX}, or ..."

    ... Also we sort of have a problem since OPEN_MAX is not
    a constant on Linux x86. I guess that means a libc enforced
    behaviour or something for that bit

OPEN_MAX is described in the <limits.h> POSIX man page
as a runtime invariant constant. However, it is allowed
to be indeterminate, so no problems arise, I think.

Andries
