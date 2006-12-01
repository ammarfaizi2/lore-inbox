Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031422AbWLANlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031422AbWLANlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031489AbWLANlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:41:45 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:49567 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1031422AbWLANlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:41:44 -0500
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
	hyper-threading.
From: Ben Collins <ben.collins@ubuntu.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20061201132918.GB4239@ucw.cz>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	 <11648607733630-git-send-email-bcollins@ubuntu.com>
	 <20061201132918.GB4239@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 08:41:40 -0500
Message-Id: <1164980500.5257.922.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 13:29 +0000, Pavel Machek wrote:
> Hi!
> 
> > This patch adds a config option to allow disabling hyper-threading by
> > default, and a kernel command line option to changes this default at
> > boot time.
> 
> > +config X86_HT_DISABLE
> > +	bool "Disable Hyper-Threading by default"
> > +	depends on X86_HT
> > +	default n
> > +
> 
> Command line options are fine, but additional config options mirroring
> command line functionality look ugly to me...

There's actually two parts to the patch. One is the kernel command line
option to allow HT to be enabled/disabled. The second is this config
option that allows the default to be off instead of the current
always-on.

The idea is that we want our users to be able to use hyper-threading,
but we don't want it on by default.
