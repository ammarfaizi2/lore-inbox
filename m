Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTJ1OvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTJ1OvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 09:51:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:34314 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263985AbTJ1OvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 09:51:11 -0500
Message-ID: <3F9E84A5.2060500@aitel.hist.no>
Date: Tue, 28 Oct 2003 16:00:53 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: Amir Hermelin <amir@montilio.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how do file-mapped (mmapped) pages become dirty?
References: <006901c39d50$0b1313d0$2501a8c0@CARTMAN>
In-Reply-To: <006901c39d50$0b1313d0$2501a8c0@CARTMAN>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amir Hermelin wrote:
> Hi,
> When a process mmaps a file, how does the kernel know the memory has been
> written to (and hence the page is dirty)? Is this done by setting the
> protected flag, and when the memory is first written to it's set to dirty?

No need on a i386.  The cpu sets the page dirty in the pagetables
when it is written to.  It doesn't matter what kind of page
it is.

> What function is responsible for this setting? And when will the page be
> written back to disk (i.e. where's the flusher located)?
> 
When there's memory pressure, or a sync.

Helge Hafting

