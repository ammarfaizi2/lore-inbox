Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286170AbRLTGJb>; Thu, 20 Dec 2001 01:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286169AbRLTGJQ>; Thu, 20 Dec 2001 01:09:16 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:44672 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286165AbRLTGHp>; Thu, 20 Dec 2001 01:07:45 -0500
Date: Thu, 20 Dec 2001 01:07:42 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, cs@zip.com.au, billh@tierra.ucsd.edu,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220010742.A4254@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112192136300.19214-100000@penguin.transmeta.com> <20011219.215730.66180642.davem@redhat.com> <20011220005928.F3682@redhat.com> <20011219.220247.101870714.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.220247.101870714.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 10:02:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 10:02:47PM -0800, David S. Miller wrote:
> Why are you limiting me to a single process? :-)  Can I have at least
> 1 per cpu possibly? :-)))

1 process.  1 cpu machine.  1 gige card.  As much ram as you want.  No 
syscalls.  Must exhibit a load curve similar to:

	y
	|  ...............
	| .
	|.
	+----------------x

Where x == requests per second sent to the machine and y is the number 
of resposes per second sent out of the machine.  Hint: read the phttpd 
and /dev/poll papers for an idea of the breakdown that happens for larger 
values of x (make the cpu slower to cause the interesting points to move 
lower).  For a third dimension to the graph, make the number of total 
connections the z axis.

		-ben
-- 
Fish.
