Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264197AbUEXJMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUEXJMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 05:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUEXJMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 05:12:16 -0400
Received: from gate.corvil.net ([213.94.219.177]:63753 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S264206AbUEXJId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 05:08:33 -0400
Message-ID: <40B1BB78.70508@draigBrady.com>
Date: Mon, 24 May 2004 10:08:08 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       akpm@osdl.org
Subject: Re: i486 emu in mainline?
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523105130.GA588@samarkand.rivenstone.net> <20040523115936.GB16726@alpha.home.local>
In-Reply-To: <20040523115936.GB16726@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sun, May 23, 2004 at 06:51:30AM -0400, Joseph Fannin wrote:
> 
>>On Sun, May 23, 2004 at 10:29:12AM +0200, Willy Tarreau wrote:
>>
>>>On Sun, May 23, 2004 at 01:40:59AM +0200, Christoph Hellwig wrote:
>>>
>>>>These days gcc uses i486+ only instruction by default in libstdc++ so
>>>>most modern distros wouldn't work on i386 cpus anymore.  To make it work
>>>>again Debian merged Willy Tarreau's patch to trap those and emulate them
>>>>on real i386 cpus.  The patch is extremely non-invasive and would
>>>>certainly be usefull for mainline.  Any reason not to include it?
>>
>>>  - I couldn't emulate locks, so this will break on SMP systems, and so
>>>    will it if you need to access some memory share with an external
>>>    microcontroller or something like that.
>>
>>    Does this mean that programs that use the NPTL will work on
>>non-SMP 386s?
> 
> I have no idea. Why would NPTL not work on i386 ?

i386 doesn't have the necessary instructions.
It's my understanding that the following is not being maintained:
http://sources.redhat.com/ml/libc-hacker/2004-05/msg00019.html

Pádraig.
