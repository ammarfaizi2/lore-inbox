Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVF2AmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVF2AmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVF2AlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:41:19 -0400
Received: from alpha.polcom.net ([217.79.151.115]:1505 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262250AbVF2Afb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:35:31 -0400
Date: Wed, 29 Jun 2005 02:35:25 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accessing loopback filesystem+partitions on a file
In-Reply-To: <20050628233335.GB9087@lkcl.net>
Message-ID: <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net>
References: <20050628233335.GB9087@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Luke Kenneth Casson Leighton wrote:

> [if you are happy to reply at all, please reply cc'd thank you.]
>
> hi,
>
> i'm really sorry to be bothering people on this list but i genuinely
> don't what phrases to google for what i am looking for without getting
> swamped by useless pages, which you will understand why when you see
> the question, below.
>
> the question is, therefore:
>
> 	* how the hell do you loopback mount (or lvm mount
> 	  or _anything_! something!)  partitions that have
> 	  been created in a loopback'd file!!!!
>
> 	  [aside from booting up a second pre-installed xen
> 	  guest domain and making the filesystem-in-a-file
> 	  available as /dev/hdb of course.]
>
> answers of the form "work out where the partitions are, then use
> hexedit to remove the first few blocks" will win no prizes here.

The bad news: it was impossible (or at least very hard to do).

The good news: it is possible now. The anwser is:
- figure where the partitions are (possibly using some simple script),
- use device-mapper to create block devices covering partitions,
- mount them.

I do not know if this anwser will win your price but it is IMHO far better 
than hexedit... :-) And probably this is the only anwser.

(IIRC if you have one partition you can skip partition table with offset 
option to losetup. But this will only work in this special case...)


Grzegorz Kulewski

