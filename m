Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUD2JmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUD2JmC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUD2JmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:42:01 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62469 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263962AbUD2JmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:42:00 -0400
Message-ID: <4090CE3D.2010106@aitel.hist.no>
Date: Thu, 29 Apr 2004 11:43:25 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: brettspamacct@fastclick.com
CC: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40905127.3000001@fastclick.com>
In-Reply-To: <40905127.3000001@fastclick.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett E. wrote:
[...]
> Or how about "Use ALL the cache you want Mr. Kernel.  But when I want 
> more physical memory pages, just reap cache pages and only swap out when 
> the cache is down to a certain size(configurable, say 100megs or 
> something)."

Problem: reaping cache is equivalent to swapping in some cases.
The cache isn't merely "files read & written".
It is also all your executable code.  Code is not different from
files being read at all.  Dumping too much cache will dump the
code you're executing, and then it have to be reloaded from disk.


Helge Hafting

