Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTBXW3e>; Mon, 24 Feb 2003 17:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTBXW3e>; Mon, 24 Feb 2003 17:29:34 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64438 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261463AbTBXW3d>; Mon, 24 Feb 2003 17:29:33 -0500
Date: Mon, 24 Feb 2003 17:39:34 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030224173934.T3910@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com> <jeznol5plv.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <jeznol5plv.fsf@sykes.suse.de>; from schwab@suse.de on Mon, Feb 24, 2003 at 10:35:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 10:35:24PM +0100, Andreas Schwab wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> |> Does gcc still warn about things like
> |> 
> |> 	#define COUNT (sizeof(array)/sizeof(element))
> |> 
> |> 	int i;
> |> 	for (i = 0; i < COUNT; i++)
> |> 		...
> |> 
> |> where COUNT is obviously unsigned (because sizeof is size_t and thus 
> |> unsigned)?
> |> 
> |> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
> 
> How can you distinguish that from other occurrences of (int)<(size_t)?

Value range propagation pass, then warn?

	Jakub
