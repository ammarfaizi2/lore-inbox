Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUE2WhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUE2WhB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 18:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUE2WhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 18:37:01 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:3712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261169AbUE2WhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 18:37:00 -0400
Date: Sun, 30 May 2004 00:36:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>
Cc: Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       Rob Landley <rob@landley.net>, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040529223648.GB1535@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au> <40B85024.2040505@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B85024.2040505@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Andrew, in 2.6.6 shrink_all_memory() does not work if swappiness ==
0. shrink_all_memory() calls balance_pgdat(), that calls
shrink_zone(), and that calls refill_inactive_zone(), which looks at
swappiness.

Additional parameter to all these calls neutralizing swappiness would
help, as would temporarily setting swappiness to 100 in
shrink_all_memory. Is there a less ugly solution?
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
