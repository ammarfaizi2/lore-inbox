Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWJMRut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWJMRut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWJMRut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:50:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:46194 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751677AbWJMRus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:50:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=T31Xkr2WKbtqL+FU2mAS+kFhCIpuFo3+Cfn7786XTSCxX9FoezEWGB3VnCL+DzyrC3cZCoLw2TVoEzHFOT7yQGLyiwRKyLFiudYWNEAYIBruMjhK1TbP2v1CYotbgwTZ3ajl6tIl1OpQvQv2wa+kAC7D/s2OgN6a9mdaBdx3V08=
Date: Sat, 14 Oct 2006 02:51:16 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 4/7] fault-injection capability for alloc_pages()
Message-ID: <20061013175116.GC29079@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ak@suse.de, Don Mullis <dwm@meer.net>
References: <20061012074305.047696736@gmail.com> <452df22a.6ff794a4.60eb.4092@mx.google.com> <20061012144042.b6d43c01.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012144042.b6d43c01.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:40:42PM -0700, Andrew Morton wrote:

> What I found was a reasonable fix for this problem was to limit the
> failures to those requests which did not have __GFP_HIGHMEM set.  That way,
> userspace allocations work, but kernel-internal allocations are subject to
> failures.

This is what I want especally when I ran the script in fault-inject.txt.
This would be quite useful.

