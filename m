Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270774AbTHJXAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbTHJXAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:00:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270774AbTHJXAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:00:41 -0400
Message-ID: <3F36CE8D.8090201@pobox.com>
Date: Sun, 10 Aug 2003 19:00:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ranty@debian.org, linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [PATCH] [2.6.0-test3] request_firmware related problems.
References: <20030810210646.GA6746@ranty.pantax.net> <20030810142928.4b734e8d.akpm@osdl.org> <3F36CD93.4010704@pobox.com>
In-Reply-To: <3F36CD93.4010704@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> So, in terms of concrete suggestions:
> 
> 1) if schedule_work is called and no kevent thread is available, create 
> a new one
> 2) ponder perhaps an implementation that would use generic keventd until 
> a certain load is reached; then, create per-cpu kernel threads just like 
> private workqueue creation occurs now.  i.e. switch from shared 
> (keventd) to private at runtime.


3) offer private workqueue interface like we have now -- but one thread 
only, not NN threads

