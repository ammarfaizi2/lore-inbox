Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbSJ2SMx>; Tue, 29 Oct 2002 13:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSJ2SMx>; Tue, 29 Oct 2002 13:12:53 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:30431 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S262065AbSJ2SMl>;
	Tue, 29 Oct 2002 13:12:41 -0500
Message-ID: <3DBED111.96A3A1E8@hp.com>
Date: Tue, 29 Oct 2002 11:18:57 -0700
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
Cc: Khalid Aziz <khalid@fc.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Retrieve configuration information from kernel
References: <Pine.LNX.4.10.10210291204590.28595-100000@clements.sc.steeleye.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:
> 
> Have you considered compressing the config info in order to reduce
> the space wastage in the loaded kernel image? Could easily be 10's of KB
> (not that that's a lot these days). The info would then be retrieved via
> "gunzip -c", et al. instead of a simple "cat".

I wanted to start with a simple implementation first. There are a couple
of things that can be done in future to further improve meory usage: (1)
Drop "CONFIG_" and "# CONFIG_" from each line and add it back when
printing from /proc/ikconfig and extract-ikconfig script, (2) Compress
the resulting configuration. Something to do in near future :)

-- 
Khalid

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini
