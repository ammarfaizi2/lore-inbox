Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVKOLRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVKOLRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 06:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKOLRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 06:17:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:6804 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932368AbVKOLRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 06:17:48 -0500
Date: Tue, 15 Nov 2005 05:17:31 -0600
From: Robin Holt <holt@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, hch@infradead.org
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115111731.GA9976@lnx-holt.americas.sgi.com>
References: <20051114212341.724084000@sergelap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114212341.724084000@sergelap>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 03:23:41PM -0600, Serge E. Hallyn wrote:
> --
> 
> I'm part of a project implementing checkpoint/restart processes.
> After a process or group of processes is checkpointed, killed, and
> restarted, the changing of pids could confuse them.  There are many
> other such issues, but we wanted to start with pids.

Can't you just build a restart preloader which intercepts system calls
and translates pids?  Wouldn't this keep the kernel simpler and only
affect those applications that are being restarted?  Christoph, I
added you since you seem to tirelessly promote using preloaders to
work around this type of issue.  Is it possible?

Thanks,
Robin
