Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbUALFFJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 00:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266047AbUALFFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 00:05:08 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24839 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266045AbUALFFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 00:05:03 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0 NFS-server low to 0 performance
Date: Mon, 12 Jan 2004 00:06:31 -0500
Organization: TMR Associates, Inc
Message-ID: <btt971$3p8$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange> <1073745028.1146.13.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073883169 3880 192.168.12.10 (12 Jan 2004 04:52:49 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1073745028.1146.13.camel@nidelv.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> No! People who have problems with the support for large rsize/wsize
> under UDP due to lost fragments can
> 
>   a) Reduce r/wsize themselves using mount
>   b) Use TCP instead
> 
> The correct solution to this problem is (b). I.e. we convert mount to
> use TCP as the default if it is available. That is consistent with what
> all other modern implementations do.
> 
> Changing a hard maximum on the server in order to fit the lowest common
> denominator client is simply wrong.

So set the default buffer size to 8k if UDP is being used. Other than 
getting people to believe 2.6 is broken, you buy nothing. People running 
UDP are probably not cutting edge state of the art, let the default be 
small and the client negotiate up if desired.

Why do so many Linux people have the idea that because a standard says 
they CAN do something, it's fine to do it in a way which doesn't conform 
to common practice. And Linux 2.4 practice should count even if you 
pretend that Solaris, AIX, Windows and BSD don't count...

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
