Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUAEQTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUAEQTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:19:35 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:488 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264454AbUAEQTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:19:34 -0500
Date: Mon, 5 Jan 2004 11:18:52 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Roland Dreier <roland@topspin.com>
cc: <erik@hensema.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: something is leaking memory
In-Reply-To: <52wu87wfzp.fsf@topspin.com>
Message-ID: <Pine.GSO.4.33.0401051116240.26470-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2004, Roland Dreier wrote:
>Yup, looks like IPv6 is leaking memory (since your netstat shows
>nowhere near 19K sockets):
>
> > tcp6_sock          19729  19732   1024    4    1 : tunables   54   27    0 : slabdata   4933   4933      0
>
>Now to figure out why...

Of course, there are a lot of sockets in CLOSE_WAIT.  That's where I'd start
looking... if I actually cared about IPv6 :-)  There used to be the same
sort of problem for IPv4 (sockets would never go away), but no one ever fixed
it -- a rewrite of the network stack made it go away.

--Ricky


