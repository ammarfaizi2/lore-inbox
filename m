Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbULEHT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbULEHT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULEHT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:19:58 -0500
Received: from relay00.pair.com ([209.68.1.20]:46854 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261270AbULEHTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:19:55 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <41B2A853.9050504@kegel.com>
Date: Sat, 04 Dec 2004 22:18:59 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal for a userspace "architecture portability" library
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland () redhat ! com> wrote:
 >> I don't think glibc exports any atomic operations.
 >
 >That is true.  But it does have implementations in bits/atomic.h for many
 >processors, and that is under the LGPL.

Interesting.  This seems to be new as of glibc-2.3.3.
(glibc-2.3.2 had implementations of all sorts of things,
spinlocks even, but they were all internal.)

gcc's libstdc++ also exports an atomicity.h
(in e.g. /usr/include/c++/3.4.2/bits/atomicity.h).

gcc's libjava also has its own set of lock primitives
(buried in a file named locks.h).

It would be quite the engineering feat to demonstrate
a gcc/glibc toolchain actually using your proposed
portability layer and demonstrate zero loss of performance.
Even that might not be enough to convince the glibc
maintainer to use it...
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
