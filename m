Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUCAOmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUCAOmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:42:53 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:62169 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261299AbUCAOmn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:42:43 -0500
Message-ID: <40434BD7.9060301@nortelnetworks.com>
Date: Mon, 01 Mar 2004 09:42:31 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns=20Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl> <200402292130.55743.mmazur@kernel.pl> <c1tk26$c1o$1@terminus.zytor.com> <200402292221.41977.mmazur@kernel.pl> <yw1xn0711sgw.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> Excuse my ignorance, but why can't the headers from the kernel still
> be used.  They seem to be working fine here.

For current kernels, the "official" method is to have cleaned up copies 
of the kernel headers shipped with glibc and placed in 
/usr/include/linux and /usr/include/asm.  The "real" headers will often 
work, but not always,

To complicate things, if you add new stuff to the kernel (new ioctl 
commands, etc.) then your app needs to either link against the "real" 
headers, or else duplicate the definitions.

Its kind of a mess.

In an ideal world there would be clean "userspace" headers shipped with 
the kernel, and the kernel would then use those headers plus the 
kernel-only stuff.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

