Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSKGOfQ>; Thu, 7 Nov 2002 09:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSKGOfQ>; Thu, 7 Nov 2002 09:35:16 -0500
Received: from gateway.innominate.fta-berlin.de ([141.16.74.40]:37124 "HELO
	innominate.com") by vger.kernel.org with SMTP id <S261173AbSKGOfP>;
	Thu, 7 Nov 2002 09:35:15 -0500
Date: Thu, 7 Nov 2002 15:43:19 +0100
From: Tino Keitel <tino.keitel@innominate.com>
To: linux-kernel@vger.kernel.org
Subject: handling of empty directories by unregister_sysctl_table()
Message-ID: <20021107144319.GA30585@tkeitel001.bln.gelonet.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Innominate Security Technologies AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have a question regarding the sysctl-API. I create a new directory
structure (proc/sys/net/foo) that includes some files and a directory
that contains no files in the beginning (/proc/sys/net/foo/bar/). The
files in this directory can be registered later during runtime
(proc/net/foo/bar/1). They can also be unregisterd. If I unregister the
last file in this directory, the directory itself (the bar directory)
will also be removed. However, in my understanding this directory is
still a child of the ctl_table that creates the initial directory
structure and that also contains /proc/net/foo/bar. What am I doing
wrong?

Regards,
Tino
