Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUAMCPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 21:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbUAMCPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 21:15:18 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:33664 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S263734AbUAMCPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 21:15:15 -0500
Subject: Re: Slow NFS performance over wireless!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: hackeron@dsl.pipex.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401130155.32894.hackeron@dsl.pipex.com>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073960112.2077.17.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 21:15:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 12/01/2004 klokka 20:55, skreiv Roman Gaufman:
> I have searched all over the nfs, enabled higher caching on nfs, enabled the 
> usage of tcp, tried to pass hard, but transfer rates very poor, and only for 
> nfs transfer, so it doesn't seem my network configurations are wrong as scp, 
> html, ftp seem to work on full speed.

You should definitely enable TCP in this case.

Most likely causes: you may have a problem with echos on your wireless,
or you may have a faulty driver for your NIC.

Try looking at 'netstat -s' on both the server and the client. Monitor
the number of TCP segments sent out, number retransmitted, and number of
segments received on both ends of the connection while doing a set of
writes, then do the same for a set of reads.

Also try monitoring the wireless rates (iwlist <interface> rate), and
quality of link (iwlist <interface> ap) while this is going on. Note: if
your driver doesn't support iwlist, then just typing 'iwconfig
<interface>' might also give you these numbers.

Cheers,
  Trond
