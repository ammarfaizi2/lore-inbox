Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbUDNIvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbUDNItv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:49:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39045 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263997AbUDNIsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:48:36 -0400
Message-ID: <407CFAD7.4070606@pobox.com>
Date: Wed, 14 Apr 2004 04:48:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
References: <407CEB91.1080503@pobox.com> <20040414005832.083de325.akpm@osdl.org> <20040414010240.0e9f4115.akpm@osdl.org> <407CF201.408@pobox.com> <20040414082716.GA25439@hockin.org>
In-Reply-To: <20040414082716.GA25439@hockin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> Somewhat off the original topic, but am I the only one who finds it weird
> (and error-prone) that you have to add the same KConfig to a dozen or more
> Kconfig files?
> 
> Shouldn't there be a KConfig libe, and all you need to do for the arch is
> reference the CONFIG_FOO from the lib?  Would at least save all the
> duplicate strings and definitions...
> 
> Kconfig.lib:
> 	config DEBUG_BUFFERS
> 		bool "Enable additional filesystem buffer_head checks"
> 		depends on DEBUG_KERNEL
> 		help
> 		  If you say Y here, additional checks are performed that
> 		  aid filesystem development.
> 
> arch/*/Kconfig
> 	libpath /Kconfig.lib
> 	...
> 	insert DEBUG_BUFFERS
> 	...


Seems a lot easier just to gather the common definitions into a Kconfig 
file, and include it via the standard 'source' directive.

	Jeff



