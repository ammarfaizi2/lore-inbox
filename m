Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286156AbRLTGAo>; Thu, 20 Dec 2001 01:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286146AbRLTF6m>; Thu, 20 Dec 2001 00:58:42 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:29054 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286148AbRLTF6g>; Thu, 20 Dec 2001 00:58:36 -0500
Date: Thu, 20 Dec 2001 00:58:03 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: billh@tierra.ucsd.edu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220005803.E3682@redhat.com>
In-Reply-To: <20011219190716.A26007@burn.ucsd.edu> <20011219.191354.65000844.davem@redhat.com> <20011219224717.A3682@redhat.com> <20011219.213910.15269313.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.213910.15269313.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 09:39:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:39:10PM -0800, David S. Miller wrote:
>    How about faster select and poll?
> 
> You don't need faster select and poll as demonstrated by the
> userspace "faster than TUX" example above.

Step back for a moment.  I know of phttpd and zeus.  They both have 
a serious problem: they fall down when the load on the system exceeds 
the capabilities of the cpu.  If you'd bother to take a look at the 
aio api I'm proposing, it has less overhead under heavy load as events 
get coalesced.  Even then, the overhead under light load is less than 
signals or select or poll.

		-ben
-- 
Fish.
