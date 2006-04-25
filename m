Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWDYG1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWDYG1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWDYG1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:27:10 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:23293 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932116AbWDYG1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:27:09 -0400
Date: Tue, 25 Apr 2006 14:27:07 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/4] kref: warn kref_put() with unreferenced kref
Message-ID: <20060425062707.GD5698@miraclelinux.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083341.613638000@localhost.localdomain> <20060425035128.GB18085@kroah.com> <20060425043410.GA5698@miraclelinux.com> <20060425050951.GB23373@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425050951.GB23373@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there some reason you created these patches?  Were you trying to
> debug something that was tracked down to a kref issue?

I can find many places where I can replace refcounter with kref by doing
"grep -r atomic_dec_and_test linux/".

If we have this detection of kref_put() with unreferenced object,
The work of kref convertions would be more than code cleanup and
consolidation.
