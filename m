Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276766AbRJKTz3>; Thu, 11 Oct 2001 15:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276793AbRJKTzT>; Thu, 11 Oct 2001 15:55:19 -0400
Received: from peace.netnation.com ([204.174.223.2]:39436 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S276766AbRJKTzI>; Thu, 11 Oct 2001 15:55:08 -0400
Date: Thu, 11 Oct 2001 12:55:38 -0700
From: Simon Kirby <sim@netnation.com>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
Message-ID: <20011011125538.C10868@netnation.com>
In-Reply-To: <20011011114736.A13722@netnation.com> <200110111930.XAA28404@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200110111930.XAA28404@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Oct 11, 2001 at 11:30:25PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 11:30:25PM +0400, kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > Is there something that changed from 2.2 -> 2.4 with regards to the
> > speed of netstat and /proc/net/tcp?
> 
> Incredibly high size of hash table, I think.
> At least here size is ~1MB. And all this is read each 1K of data read
> via /proc/ :-)

So it's walking the hash table per block read, and the hash table is very
large?  Hmm.  I notice it's a bit faster if I use dd if=/proc/net/tcp
of=/dev/null bs=1024k, but not much.

Is it possible to fix this?  Was the 2.2 hash table just that much
smaller?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
