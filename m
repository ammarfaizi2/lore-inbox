Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282872AbRLQVBy>; Mon, 17 Dec 2001 16:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282873AbRLQVBp>; Mon, 17 Dec 2001 16:01:45 -0500
Received: from a56d18.elisa.omakaista.fi ([212.54.5.56]:7296 "EHLO
	masiina.localdomain") by vger.kernel.org with ESMTP
	id <S282872AbRLQVBg>; Mon, 17 Dec 2001 16:01:36 -0500
Message-ID: <3C1E5D26.8050400@retiisi.dyndns.org>
Date: Mon, 17 Dec 2001 23:01:26 +0200
From: Sakari Ailus <sailus@retiisi.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: fi, en-us, sv
MIME-Version: 1.0
To: Diego Calleja <grundig@teleline.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
In-Reply-To: <20011216184836.A418@diego> <20011216211208.D5226@vestdata.no> <20011217025856.A1649@diego>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

> badblocks -n (non-destructive write-test) -vv /dev/hdc5
> results in:
> attempt to access beyond end of device
> 16:05: rw=0, want=9671068, limit=9671067
> attempt to access beyond end of device
> 16:05: rw=0, want=9671068, limit=9671067
> attempt to access beyond end of device
> 16:05: rw=0, want=9671068, limit=9671067
> 3 bad blocks found
> 
> This means it's broken? 

No, it is what it says, AFAIK.

read/write/whatever system call tries to access past end of device 
although it isn't asked to (or the problem is somewhere deeper). This 
has happened to me on swap partition which had fairly dramatic effect. 
;-) Not using last few blocks solved the problem. Of course, this 
shouldn't be the case...

-- 
Sakari Ailus
sakari.ailus@retiisi.dyndns.org

