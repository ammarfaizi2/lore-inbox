Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288477AbSAIDrq>; Tue, 8 Jan 2002 22:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288478AbSAIDrg>; Tue, 8 Jan 2002 22:47:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288477AbSAIDrc>; Tue, 8 Jan 2002 22:47:32 -0500
Message-ID: <3C3BBD50.2020805@zytor.com>
Date: Tue, 08 Jan 2002 19:47:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>	<20020108201451.088f7f99.rusty@rustcorp.com.au>	<a1f9j9$5i9$1@cesium.transmeta.com>	<20020109120108.39bcf7ad.rusty@rustcorp.com.au>	<a1gcme$18t$1@cesium.transmeta.com> <200201090330.g093UB427696@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

>>>
>>So you chown an entry, then a module is unloaded and reloaded, now
>>what happens?
>>
>>It's the old "virtual filesystem which really wants persistence"
>>issue again...
>>
> 
> Works beautifully with devfs+devfsd :-)
> 
> Permissions get saved elsewhere in the namespace (perhaps even to the
> underlying /dev) as you chown(2)/chmod(2)/mknod(2), and are restored
> when entries are (re)created and/or at startup.
> 
> My /dev has persistence behaviour which looks like a FS with backing
> store.
> 


Yes, after quite a few years it finally got in there.  This is a Good 
Thing[TM].  Now apply the same problem to /proc.

	-hpa


