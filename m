Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTFDEeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 00:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTFDEeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 00:34:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51189 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262805AbTFDEeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 00:34:13 -0400
Message-ID: <3EDD7832.7010804@us.ibm.com>
Date: Tue, 03 Jun 2003 21:40:18 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       jmorris@intercode.com.au, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
References: <200306040043.EAA24505@dub.inr.ac.ru>	<3EDD52F5.8090706@us.ibm.com>	<20030603.202320.59680883.davem@redhat.com> <16093.30507.661714.676184@napali.hpl.hp.com>
In-Reply-To: <16093.30507.661714.676184@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

>   DaveM> So if your old SpecWEB99 lab tended more to trigger timeout
>   DaveM> based retransmits on LAN, and your new test network does not,
>   DaveM> then your new test network will tend to not reproduce the bug
>   DaveM> regardless of whether the bug is present in the kernel or not
>   DaveM> :-)
> 
> Is this where I get to plug httperf?  It triggered the bug reliably in
> less than 10 secs. ;-)

Tarnation!! Ran httperf! Didnt hit it! :(. What were your
settings?

I extracted an old debug patch to implement dropping of
packets - have a sysctl that controls the rate at which I
can drop IP packets, so can also generate any kind of packet
loss..So thought I would bang away with netperf using
sendfile()/TCP_CORK. Thought it was in that code path.
Will be running tests tmrw and the rest of this
week on 2.5.70 +- patch. Will see if I can provoke any
further hangs, stalls, wackiness of any flavor...

thanks,
Nivedita


