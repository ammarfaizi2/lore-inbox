Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbTINBh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 21:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbTINBh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 21:37:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:61828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262276AbTINBh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 21:37:56 -0400
Date: Sat, 13 Sep 2003 18:38:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [PATCH][2.6] remove extraneous information from ikconfig
Message-Id: <20030913183804.03ea3283.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0309131910070.3274@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0309131910070.3274@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
>  /proc/version provides the same information as /proc/config_build_info, 

Well it is supposed to:

vmm:/home/akpm> cat /proc/config_build_info
Kernel:    Linux 2.6.0-test5-mm2 #6 SMP Fri Sep 12 20:14:44 PDT 2003 i686
Compiler:  gcc version 2.95.3 20010315 (release)
Version_in_Makefile: 2.6.0-test5-mm2

vmm:/home/akpm> cat /proc/version          
Linux version 2.6.0-test5-mm2 (akpm@mnm) (gcc version 2.95.3 20010315 (release)) #18 SMP Sat Sep 13 18:18:33 PDT 2003

config_build_info gets the .version wrong: it should be #18

>  ergo i propose the following patch for your consideration.

I think so...
