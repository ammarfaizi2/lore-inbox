Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270717AbRHKElj>; Sat, 11 Aug 2001 00:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270718AbRHKEla>; Sat, 11 Aug 2001 00:41:30 -0400
Received: from james.kalifornia.com ([208.179.59.2]:56624 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S270717AbRHKElQ>; Sat, 11 Aug 2001 00:41:16 -0400
Message-ID: <3B74B745.9090006@blue-labs.org>
Date: Sat, 11 Aug 2001 00:40:37 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010809
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: VM nuisance
In-Reply-To: <Pine.LNX.4.33L.0108110117160.3530-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps a tunable load value w/ kswapd?  If you're trying to accomplish 
more than N iterations of kswapd's particular function...take your pick, 
then make the OOM killer more trigger happy, perhaps on a sliding scale. 
 At least then -something- will get killed the harder we try to get 
pages.  As it is now, it's very likely the kernel get's stuck on itself 
for hours on end...sometimes never recovering.  I suspect the only 
reason why I recovered it was because I happened to have about 8 ssh 
sessions to other machines that I was able to kill them on.

David

Rik van Riel wrote:

>Actually the killer itself isn't the problem.
>
>It's deciding when to let it kick in.
>


