Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312894AbSDOQGp>; Mon, 15 Apr 2002 12:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312896AbSDOQGo>; Mon, 15 Apr 2002 12:06:44 -0400
Received: from panther.fit.edu ([163.118.5.1]:47003 "EHLO fit.edu")
	by vger.kernel.org with ESMTP id <S312894AbSDOQGo>;
	Mon, 15 Apr 2002 12:06:44 -0400
Message-ID: <3CBAF8EC.6070403@fit.edu>
Date: Mon, 15 Apr 2002 11:59:40 -0400
From: Kervin Pierre <kpierre@fit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020410
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
CC: ivan <ivan@es.usyd.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Memory Leaking. Help!
In-Reply-To: <Pine.LNX.4.33.0204151017480.20961-100000@dipole.es.usyd.edu.au> <3CBAC6B3.2040002@gointernet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugenio Mastroviti wrote:
> much data as it can in memory. The actual memory in use (check with 
> 'free') is total-(buffers+cache)= 2.2-(0.37+1.51)GB=about 320 MB, which 

This is interesting.  What exactly is buffers and cache used for?

I had the same issue with the original poster with a new server.  A 
fresh install with nothing significant running ( no bind nor sendmail, 
etc. ) reported that over 450 out of 512 MB was used, but looking at the 
process usage on top I barelly got 5% memory usuage by process.  If the 
above calculation ( memory use = total - buffers - cache ) is correct 
then the memory use drops to ~100 MB.

I guess what's confusing is that total memory usuage is including 
buffers and cache.  If that memory is available to applications, 
shouldn't it be removed from the "total used" figure?

--Kervin


-- 
http://linuxquestions.org/ - Ask linux questions, give linux help.
http://splint.org/ - Write safe C code. splint source-code analyzer.

