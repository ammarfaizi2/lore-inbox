Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbTHYEKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 00:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTHYEKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 00:10:34 -0400
Received: from holomorphy.com ([66.224.33.161]:41126 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261415AbTHYEK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 00:10:29 -0400
Date: Sun, 24 Aug 2003 21:11:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030825041117.GN4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20030821234709.GD1040@matchmail.com> <AC36AB3038685indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AC36AB3038685indou.takao@soft.fujitsu.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 09:49:45AM +0900, Takao Indoh wrote:
>>> Actually, in the system I constructed(RedHat AdvancedServer2.1, kernel
>>> 2.4.9based), the problem occurred due to pagecache. The system's maximum
>>> response time had to be less than 4 seconds, but owing to the pagecache,
>>> response time get uneven, and maximum time became 10 seconds.

On Thu, 21 Aug 2003 16:47:09 -0700, Mike Fedyk wrote:
>> Please try the 2.4.18 based redhat kernel, or the 2.4-aa kernel.

On Mon, Aug 25, 2003 at 11:45:58AM +0900, Takao Indoh wrote:
> I need a tuning parameter which can control pagecache
> like /proc/sys/vm/pagecache, which RedHat Linux has.
> The latest 2.4 or 2.5 standard kernel does not have such a parameter.
> 2.4.18 kernel or 2.4-aa kernel has a alternative method?

This is moderately misguided; essentially the only way userspace can
utilize RAM at all is via the pagecache. It's not useful to limit this;
you probably need inode-highmem or some such nonsense.


-- wli
