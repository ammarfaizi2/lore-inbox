Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbUAMUqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUAMUqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:46:04 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:5264
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265611AbUAMUqB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:46:01 -0500
Subject: Re: Slow NFS performance over wireless!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Joshua M. Thompson" <funaho@jurai.org>
Cc: hackeron@dsl.pipex.com, linux-kernel@vger.kernel.org
In-Reply-To: <1074025508.1987.10.camel@lumiere>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
	 <1074025508.1987.10.camel@lumiere>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074026758.4524.65.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 13 Jan 2004 15:45:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 13/01/2004 klokka 15:25, skreiv Joshua M. Thompson:
> I've noticed a similar problem here since upgrading to 2.6. In my case
> not has NFS performance gone through the floor vs 2.4.22 but so has
> machine performance during the transfer. In 2.4 the machine would be a
> bit sluggish but usable...under 2.6 the machine is more or less
> *unusable* until the NFS transfer completes. Trying to say, open up
> Evolution may take upwards of ten minutes to complete. Unfortunately due
> to the extreme performance problem it's not even possible to do any
> diagnostics on the machine while it's happening.

There are a couple of performance related patches that should be applied
to stock 2.6.0/2.6.1. One handles a problem with remove_suid()
generating a whole load of SETATTR calls if you are writing to a file
that has the "x" bit set. The other handles an efficiency issue related
to random write + read combinations.

Either look for them on my website (under
http://www.fys.uio.no/~trondmy/src), or apply Andrew's 2.6.1-mm2 patch.

Cheers,
  Trond
