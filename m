Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVDGPhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVDGPhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVDGPhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:37:39 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39345 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262493AbVDGPhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:37:20 -0400
Date: Thu, 7 Apr 2005 17:36:59 +0200 (CEST)
From: Simon Derr <simon.derr@bull.net>
X-X-Sender: derr@localhost.localdomain
To: Yura Pakhuchiy <pakhuchiy@iptel.by>
Cc: Patrice Martinez <patrice.martinez@ext.bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/random problem on 2.6.12-rc1
In-Reply-To: <1112879666.2035.10.camel@chaos.void>
Message-ID: <Pine.LNX.4.58.0504071727080.5654@localhost.localdomain>
References: <42552A33.6070704@ext.bull.net> <1112879666.2035.10.camel@chaos.void>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/04/2005 17:47:02,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/04/2005 17:47:04,
	Serialize complete at 07/04/2005 17:47:04
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Yura Pakhuchiy wrote:

> On Thu, 2005-04-07 at 14:40 +0200, Patrice Martinez wrote:
> > When  using a machine with a  2612-rc 1kernel, I encounter problems
> > reading /dev/random:
> >  it simply nevers returns anything, and the process is blocked in the
> > read...
> > The easiest way to see it is to type:
> >  od < /dev/random
> >
> > Any idea?
>
> Because, /dev/random use user input, mouse movements and other things to
> generate next random number. Use /dev/urandom if you want version that
> will never block your machine.
>
> Read "man 4 random" for details.
>
Something changed since previous versions of the kernel, I guess.
Running `find /usr | wc' on a ssh session generates both network and disk
activity, and you should not expect any other kind of input on a networked
server.

Anyway, still zero bytes coming from /dev/random, for the few minutes I
waited.

This on Linux-2.6.12-rc-bk1, on IA64.



