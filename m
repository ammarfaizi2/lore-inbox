Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbTCZNh3>; Wed, 26 Mar 2003 08:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTCZNh3>; Wed, 26 Mar 2003 08:37:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53658 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261692AbTCZNh1>;
	Wed, 26 Mar 2003 08:37:27 -0500
Message-ID: <3E81AFCD.10709@pobox.com>
Date: Wed, 26 Mar 2003 08:49:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Matt Mackall <mpm@selenic.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
References: <3E81132C.9020506@pobox.com> <200303252053.h2PKrRn09596@oboe.it.uc3m.es> <3E81132C.9020506@pobox.com> <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
In-Reply-To: <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> At 11:55 PM 25/03/2003 -0600, Matt Mackall wrote:
> 
>> > Yeah, iSCSI handles all that and more.  It's a behemoth of a
>> > specification.  (whether a particular implementation implements all 
>> that
>> > stuff correctly is another matter...)
>>
>> Indeed, there are iSCSI implementations that do multipath and
>> failover.
> 
> 
> iSCSI is a transport.
> logically, any "multipathing" and "failover" belongs in a layer above it 
> -- typically as a block-layer function -- and not as a transport-layer 
> function.
> 
> multipathing belongs elsewhere -- whether it be in MD, LVM, EVMS, 
> DevMapper -- or in a commercial implementation such as Veritas VxDMP, 
> HDS HDLM, EMC PowerPath, ...

I think you will find that most Linux kernel developers agree w/ you :)

That said, iSCSI error recovery can be considered as supporting some of 
what multipathing and failover accomplish.  iSCSI can be shoving bits 
through multiple TCP connections, or fail over from one TCP connection 
to another.


>> Both iSCSI and ENBD currently have issues with pending writes during
>> network outages. The current I/O layer fails to report failed writes
>> to fsync and friends.

...not if your iSCSI implementation is up to spec.  ;-)


> these are not "iSCSI" or "ENBD" issues.  these are issues with VFS.

VFS+VM.  But, agreed.

	Jeff



