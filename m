Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTICTEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTICTDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:03:21 -0400
Received: from hera.kernel.org ([63.209.29.2]:39082 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264194AbTICTCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:02:02 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: given a struct sock, how to find pid of process that owns it?
Date: Wed, 3 Sep 2003 12:00:45 -0700
Organization: Open Source Development Lab
Message-ID: <20030903120045.69df335c.shemminger@osdl.org>
References: <3F562225.4010609@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1062615659 21811 172.20.1.60 (3 Sep 2003 19:00:59 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 3 Sep 2003 19:00:59 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 13:17:25 -0400
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> 
> I'm working on a small app similar to netstat that only cares about unix 
> sockets.
> 
> I can easily walk /proc/net/unix, but to find the owner of the socket I 
> need to scan /proc, which gets expensive.
> 
> Accordingly, I'd like to extend /proc/net/unix to also dump out the pid 
> of the process that owns the socket.  The only thing is, I can't seem to 
> figure out how to find the pid of the socket owner given a pointer to 
> the socket struct.
> 

There is a N to 1 relationship, you will end up needing the scan.
