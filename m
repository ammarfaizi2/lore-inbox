Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUFSAav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUFSAav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUFSAWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:22:43 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:55791 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265418AbUFSAQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:16:57 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Date: Fri, 18 Jun 2004 20:16:48 -0400
User-Agent: KMail/1.6.2
Cc: bcasavan@sgi.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com> <200406181926.39294.jbarnes@engr.sgi.com> <20040619015652.232b3b55.ak@suse.de>
In-Reply-To: <20040619015652.232b3b55.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406182016.48376.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 18, 2004 7:56 pm, Andi Kleen wrote:
> > Sure, but that would be a change in behavior.  It's arguably the right
> > thing to do though.
>
> Change what behaviour? I argue that doing it in the kernel is the wrong
> thing.

/proc/<pid>/wchan reports the function name as a string.  You're arguing that 
doing that in the kernel is the wrong thing to do, right?  If so, it would 
make sense to change its behavior.  Either way, I guess we can fix top to 
use /proc/<pid>/stat instead, and lookup symbols in an external System.map 
file.

Jesse
