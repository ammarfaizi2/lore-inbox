Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316694AbSEWOFi>; Thu, 23 May 2002 10:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSEWOFi>; Thu, 23 May 2002 10:05:38 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:50914 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S316694AbSEWOFh>; Thu, 23 May 2002 10:05:37 -0400
Message-ID: <3CECF70C.1060208@antefacto.com>
Date: Thu, 23 May 2002 15:05:00 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: will fitzgerald <william.fitzgerald6@beer.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question:kernel profiling and readprofile
In-Reply-To: <1864B06FE5DED9149A7F262BF4C5E5DE@william.fitzgerald6.beer.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

will fitzgerald wrote:
> hi all,
> 
> i stumbled accross a command called readprofile by accident and found 
> that by appening the line append="profile=2" to the lilo.conf file 
> and using thread profile command you can get statistics on functions 
> that spend a certain amount of time doing a job.
> 
> i done some searching on this and can't find anything other than a 
> man page on readprofile.
> 
> can anyone tell me what does the line append="profile=2" actually do 
> apart from creating the file profile in the proc directory, what is 
> the 2 for in this line?

The level. see linux/Documentation/kernel-parameters.txt
Also worth looking at is http://oss.sgi.com/projects/kernprof/

> next is this an accurate way to measure heady traffic load through 
> say a linux router?

I presume you don't want to actually measure traffic throughput
as there are obviously other ways to do this.

> will it highlight all functions say for example 
> ip_forward, dev_queue_xmit etc etc that are being opverloaded due to 
> huge traffic loads being passed through the router. ie will it spot 
> bottlenecks with good accuracy?

yes that's the idea.

> any feedback is welcomed,
> regards will.

Also note CONFIG_NET_PROFILE=Y which writes more network specific
profile data to /proc/net/profile, which you'll have to figure
out how to parse.

Also I think it was reported that there were some problems
with profiling (missing symbols) around 2.5.8? I don't know
whether it's been fixed.

Also I don't think you can profile modules, but there was a patch...
http://marc.theaimsgroup.com/?l=linux-kernel&m=101663078100596&w=2

Padraig.

