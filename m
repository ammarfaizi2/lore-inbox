Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRDCJfq>; Tue, 3 Apr 2001 05:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRDCJfh>; Tue, 3 Apr 2001 05:35:37 -0400
Received: from chiara.elte.hu ([157.181.150.200]:52235 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129506AbRDCJfY>;
	Tue, 3 Apr 2001 05:35:24 -0400
Date: Tue, 3 Apr 2001 10:33:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Srinivas Surabhi <srinivas.surabhi@wipro.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: how to create in proc
In-Reply-To: <4ebc65372d.5372d4ebc6@wipro.com>
Message-ID: <Pine.LNX.4.30.0104031030270.2794-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Apr 2001, Srinivas Surabhi wrote:

>    So kindly help me, what are the system calls/fuction calls to be
> used for the creation of sub-directory in /proc directory.

eg. to create a new "foo" directory in /proc/net:

        new_dir = proc_mkdir("foo", proc_net);

then use the resulting dir entry to create files in this new directory:

        entry = create_proc_entry("bar", 0700, new_dir);

and use remove_proc_entry() on the file entry and on the directory entry
to clean things up.

	Ingo

