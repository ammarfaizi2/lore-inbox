Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWAJU5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWAJU5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWAJU5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:57:44 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:3224 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932628AbWAJU5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:57:39 -0500
Message-ID: <43C40738.4070600@wolfmountaingroup.com>
Date: Tue, 10 Jan 2006 12:12:56 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>	 <20060110133728.GB3389@suse.de>	 <Pine.LNX.4.63.0601100840400.9511@winds.org>	 <20060110143931.GM3389@suse.de>	 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>	 <43C3F986.4090209@mbligh.org>	 <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>	 <43C3E74D.7060309@wolfmountaingroup.com> <1136926519.14532.46.camel@localhost.localdomain>
In-Reply-To: <1136926519.14532.46.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Maw, 2006-01-10 at 09:56 -0700, Jeff V. Merkey wrote:
>  
>
>>RH ES uses 4:4 which is ideal and superior to this hack.
>>    
>>
>
>Its a non trivial trade-off. 4/4 lets you run very large physical memory
>systems much more efficiently than usual but you pay a cost on syscalls
>and some other events when using the majority of processors. The 4/4
>tricks also give most emulations (eg Qemu) serious heartburn trying to
>emulate %cr3 reloading via mmap and other interfaces with high overhead
>in relative terms.
>
>Of course AMD64 kind of shot the problem in the head once and for all.
>
>  
>

Yep, they sure did.  Seriously, the 4:4 option should also be present 
along with 3:1 and 2:2
splits.  You should merge your RH work into this patch and allow both.  
It would save me one less
patch to maintain off the tree.

Alan, you're the man.

:-)

Jeff

>Alan
>
>
>  
>

