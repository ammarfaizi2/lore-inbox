Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276993AbRJKWL3>; Thu, 11 Oct 2001 18:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276990AbRJKWLU>; Thu, 11 Oct 2001 18:11:20 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55523 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S276993AbRJKWLN>;
	Thu, 11 Oct 2001 18:11:13 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 11 Oct 2001 22:11:11 GMT
Message-Id: <UTC200110112211.WAA33043.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: 2.4.11 loses sda9
Cc: adilger@turbolabs.com, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now we have a big and fairly nasty mix of the stuff that can be
> turned in pointer to block device, pointer to character device _and_
> stuff that is used as numbers.

Not really. I don't know whether you ever tried the experiment
and compiled kdev_t as a pointer to a struct with two members
namely major and minor, where the struct is allocated by MKDEV().
Very few places break, and these places are very easy to fix.
Stuff that is used as numbers can be forgotten quickly.
It is not difficult at all to get a kernel up and running that has
kdev_t a pointer type.

> Moreover, allocation policy for these structures is a tricky beast.

Yes. I entirely agree. All the rest is a mechanical action.
(Or, more precisely, removable modules require freeing, and
freeing requires refcounting. It is the refcounting that is
work, more than the allocation.)

Andries
