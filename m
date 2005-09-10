Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVIJI0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVIJI0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVIJI0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:26:50 -0400
Received: from nome.ca ([65.61.200.81]:60900 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S932269AbVIJI0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:26:50 -0400
Date: Sat, 10 Sep 2005 01:27:34 -0700
From: Mike Bell <mike@mikebell.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050910082732.GR13742@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050909214542.GA29200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909214542.GA29200@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 02:45:42PM -0700, Greg KH wrote:
> Also, if people _really_ are in love with the idea of an in-kernel
> devfs, I have posted a patch that does this in about 300 lines of code,
> called ndevfs.

Except that as I mentioned, it's broken by design. It creates yet
another incompatible naming scheme for devices, and what's worse the
devices it breaks are the ones like ALSA and the input subsystem, whose
locations are hard-coded into libraries. Unless sysfs is going to get
attributes from which the proper names could be derived, it won't ever
work.
