Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUBGIbI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 03:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbUBGIbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 03:31:08 -0500
Received: from lva099.siteprotect.com ([64.41.120.53]:41185 "EHLO
	lva099.siteprotect.com") by vger.kernel.org with ESMTP
	id S265615AbUBGIbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 03:31:05 -0500
Message-ID: <4024A1D8.9060700@antivir.de>
Date: Sat, 07 Feb 2004 09:29:12 +0100
From: John Ogness <jogness@antivir.de>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031207
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: File change notification
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/04 09:58, Dave Jones wrote:
 > On Thu, Jan 01, 2004 at 09:28:08AM +0800, Michael Clark wrote:
 > > Have you had a look at dazuko. It provides a consistent file access
 > > notification mechanism (and also intervention for denying access)
 > > across linux and freebsd. It is currently being used by various
 > > on-access virus scanners. It is under active development and
 > > supports 2.6 (and 2.4)
 >
 > Candidate for "Wackiest sys_call_table patching 2004".
 > In a word "ick". Code not to be read on a full stomach.

Hi,

I am the current maintainer of Dazuko. Could you please explain your 
"wackiest 2004" comment? Do you know of a better way to intercept system 
calls for 2.2/2.4 kernels *without* patching the kernel source?

System call hooking is all-around ugly, but unfortunately most operating 
systems don't provide a real mechanism for file access control. With the 
2.6 kernel, Dazuko uses LSM. This is much more elegant and much safer. 
Yes, users have to turn LSM on, but this does not require kernel patches 
(and many distributions are turning this feature on by default).

I would appreciate any feedback you may have about how it could be 
improved. Keep in mind, I refuse to do anything that requires kernel 
source patching.

John Ogness

-- 
Dazuko Maintainer

