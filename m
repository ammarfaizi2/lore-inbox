Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTD2L4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTD2L4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:56:19 -0400
Received: from boden.synopsys.com ([204.176.20.19]:36807 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S261783AbTD2L4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:56:18 -0400
Date: Tue, 29 Apr 2003 14:08:14 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Lamont Granquist <lamont@scriptkiddie.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIGRTMIN, F_SETOWN(-getpgrp()) and threads
Message-ID: <20030429120814.GF890@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030428162800.D83397-100000@uswest-dsl-142-38.cortland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428162800.D83397-100000@uswest-dsl-142-38.cortland.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lamont Granquist, Tue, Apr 29, 2003 01:34:21 +0200:
> 
> I'm attempting to send SIGRTMIN to an entire pgrp composed of threads.
> I'm running into issues with the management thread getting this signal and
> dying because it is uncaught in that thread.  Is there any way to make the
> management thread ignore this signal?  (and i'm running linux 2.4.20-ish
> and glibc-2.2.4-19.3)
> 

ignore it before pthreads are initialized?

int main(int argc, char* argv[])
{
    signal(SIGRTMIN, SIG_IGN);
    ...


