Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVA1XVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVA1XVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVA1XVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:21:35 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21379 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262817AbVA1XVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:21:34 -0500
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
	threading error
From: Lee Revell <rlrevell@joe-job.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org,
       "Trever L. Adams" <tadams-lists@myrealbox.com>
In-Reply-To: <20050128093104.61a7a387@dxpl.pdx.osdl.net>
References: <217740000.1106412985@[10.10.2.4]> <41F30E0A.9000100@osdl.org>
	 <1106482954.1256.2.camel@tux.rsn.bth.se>
	 <20050126132504.3295e07d@dxpl.pdx.osdl.net> <41F97E07.2040709@comcast.net>
	 <20050128093104.61a7a387@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 18:21:32 -0500
Message-Id: <1106954493.3051.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 09:31 -0800, Stephen Hemminger wrote:
> Here is the strace output of the part that SEGV's, looks like a DRI issue??

[snip]

> munmap(0x955838, 8192)                  = -1 EINVAL (Invalid argument)
> munmap(0x80d7ff0, 3221222108)           = -1 EINVAL (Invalid argument)
> --- SIGSEGV (Segmentation fault) @ 0 (0) ---

No, it really looks like OO tried to munmap() something incorrectly.
3,221,222,108 bytes at offset 0x80d7ff0?

Lee

