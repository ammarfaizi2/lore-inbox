Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTKCUl3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTKCUl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:41:29 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:59366 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262738AbTKCUl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:41:28 -0500
Date: Mon, 3 Nov 2003 21:41:18 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland?
Message-ID: <20031103204118.GJ16820@louise.pinerecords.com>
References: <20031103193940.GA16820@louise.pinerecords.com> <Pine.LNX.4.53.0311031519050.2654@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311031519050.2654@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov-03 2003, Mon, 15:32 -0500
Richard B. Johnson <root@chaos.analogic.com> wrote:

> 	char *argv[3];
>         argv[0] ="/sbin/init";
>         argv[1] ="auto";
>         argv[2] = NULL;
>         execve(argv[0], argv, __environ);
> 
> That will overlay and restart init from scratch.

OK, that sounds like a plan.  There's one problem, though -- I really need
to do this in a single step (i.e. I won't have console access to issue any
commands after all processes have been killed off and all the world's got
is a root shell), so the script mustn't get killed while the system is coming
down.

Thanks for help,
-- 
Tomas Szepe <szepe@pinerecords.com>
