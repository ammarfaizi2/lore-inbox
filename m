Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267676AbUBSCMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUBSCMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:12:35 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:2269 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267676AbUBSCM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:12:29 -0500
Message-ID: <40341B82.1090403@cyberone.com.au>
Date: Thu, 19 Feb 2004 13:12:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] How should delete_resource() handle children?
References: <20040210193349.GI13351@parcelfarce.linux.theplanet.co.uk> <20040218174800.0a3183ec.rddunlap@osdl.org>
In-Reply-To: <20040218174800.0a3183ec.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:

>On Tue, 10 Feb 2004 19:33:49 +0000 Matthew Wilcox <willy@debian.org> wrote:
>
>| 
>| If you call release_resource() on a resource that has children, all
>| of those children are silently removed from the list too.  Does anybody
>| currently depend on that behaviour?
>| 
>
...

>| 
>| 
>| Comments?
>
>Ideally (or if nothing depends on the current behavior), I think it
>should just be an error (return -EINVAL), not a BUG_ON().  I.e.,
>releasing a resource should be an explicit action.
>
>

-EBUSY?
