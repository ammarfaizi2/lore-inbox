Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287932AbSABTqk>; Wed, 2 Jan 2002 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSABTqa>; Wed, 2 Jan 2002 14:46:30 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:63241 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S287932AbSABTqS>; Wed, 2 Jan 2002 14:46:18 -0500
Date: Wed, 2 Jan 2002 11:46:16 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Michal Moskal <malekith@pld.org.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: strange TCP stack behiviour with write()es in pieces
In-Reply-To: <20020102162806.GA29399@ep09.kernel.pl>
Message-ID: <Pine.LNX.4.33.0201021140130.22556-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Michal Moskal wrote:

> 	void send_packet(int cmd, void *data, int len)
> 	{
> 		struct header h = { cmd, len };
>
> 		write(fd, &h, sizeof(h));
> 		write(fd, data, len);
> 	}

you should look into writev(2).

you might also want to look at this paper
<http://www.isi.edu/~johnh/PAPERS/Heidemann97a.html>, it's probably
similar to the problems you're seeing.

-dean

