Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289291AbSBNA7M>; Wed, 13 Feb 2002 19:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289282AbSBNA6t>; Wed, 13 Feb 2002 19:58:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:55777 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S289291AbSBNA6i>;
	Wed, 13 Feb 2002 19:58:38 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 14 Feb 2002 01:57:48 +0100 (MET)
Message-Id: <UTC200202140057.g1E0vmj24668.aeb@apps.cwi.nl>
To: davidsen@tmr.com, phillips@bonn-fries.net
Subject: Re: [patch] sys_sync livelock fix
Cc: akpm@zip.com.au, alan@lxorguk.ukuu.org.uk, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it should work in the _best_ way, and if the standard got it wrong
> then the standard has to change.

: BTW: I think users would expect the system call to work as the standard
: specifies, not some better way which would break on non-Linux systems. Of
: course now working programs which conform to the standard DO break on
: Linux.

Let me repeat:
The standard describes a *minimum*.
A system that does not give more than this minimum would be
a very poor system indeed.

That POSIX does not require more than 14 bytes in a filename
and does not promise me more than 6 simultaneous processes
does not prevent us from having something better.

In this particular case (sync) the minimum required is
essentially empty. The proposed semantics: make sure that
before return all writes that were scheduled at the time
of the call seems entirely satisfactory.

Andries


(BTW Is your df broken? It is very long ago that my df did
a sync.)
