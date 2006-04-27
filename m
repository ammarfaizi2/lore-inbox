Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWD0NBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWD0NBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWD0NBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:01:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37786 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965031AbWD0NBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:01:51 -0400
Date: Thu, 27 Apr 2006 14:01:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Tom Horsley <tom.horsley@ccur.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bugsy <bugsy@ccur.com>
Subject: Re: CLONE_NEWNS and mount command?
Message-ID: <20060427130149.GP27946@ftp.linux.org.uk>
References: <1146142640.23667.9.camel@tweety>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146142640.23667.9.camel@tweety>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 08:57:20AM -0400, Tom Horsley wrote:
> It disappeared from the mounts listed by the "mount" command
> in both the old and new namespace, but if I attempted to remount
> the system in the old namespace I get an error telling me it is
> already mounted (even though it doesn't show up). In the new
> namespace where I unmounted it, I can remount it (then it shows
> up again in the mount listing in both namespaces).
> 
> Should the /proc/mounts file be paying more attention to this
> "namespace" thing? Is this a bug, or just the way things happen
> to work out?

Huh?  a) /proc/mounts is the list for namespace of one who'd opened it
(it's a symlink to /proc/self/mounts).  b) are you sure that you do
not simply end up with chewing shared /etc/mtab?
