Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279585AbRJXT5H>; Wed, 24 Oct 2001 15:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279584AbRJXT45>; Wed, 24 Oct 2001 15:56:57 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56049
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279583AbRJXT4t>; Wed, 24 Oct 2001 15:56:49 -0400
Date: Wed, 24 Oct 2001 12:57:17 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: safemode <safemode@speakeasy.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: time tells all about kernel VM's
Message-ID: <20011024125717.B21511@mikef-linux.matchmail.com>
Mail-Followup-To: safemode <safemode@speakeasy.net>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0110232141080.3690-100000@imladris.surriel.com> <20011024020830Z278529-17408+4201@vger.kernel.org> <20011024115518Z279543-17408+4334@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011024115518Z279543-17408+4334@vger.kernel.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 07:55:27AM -0400, safemode wrote:
> ok.  Reran e2defrag and got the same effect.  
> This is the vmstat output by the second.  It starts out with my normal load 
> (but no mp3s playing).  Then i start e2defrag with the same arguments as 
> before and allow it to run all the way through.  It ends but i dont close it 
> until near the very end (which is seen by the swap dropoff.  Then i let my 
> normal load again be displayed a bit.  One thing i did notice, however, was 
> that the vm handled that quite a lot better than how it handled it after 
> being up for 5 days even though it created the 600MB of buffer.    
> 

Hmm.  I have seen similar behavior with:

file -type f -exec cat '{}' \; > /dev/null

I get a very big buffer cache, and very small page cache.

Kernel:
Now  : 20:56:14 running Linux
       2.4.12-ac5+acct-entropy+preempt+netdev-ramdom+vm-free-swapcache

Btw, this was on a read only NTFS partition.  I can test with ext3 if
needed...
