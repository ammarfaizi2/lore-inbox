Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWIUSIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWIUSIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWIUSIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:08:22 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:29188 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751425AbWIUSIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:08:21 -0400
Message-ID: <4512D4FB.5000803@shadowen.org>
Date: Thu, 21 Sep 2006 19:07:55 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.18-rc7-mm1 -- ppc64 crash in slab_node ??
References: <20060919012848.4482666d.akpm@osdl.org> <45128F94.1080502@shadowen.org> <20060921102823.628a2a74.akpm@osdl.org> <Pine.LNX.4.64.0609211100350.5959@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609211100350.5959@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 21 Sep 2006, Andrew Morton wrote:
> 
>> I guess the below will fix it.  But Christoph's machine would have oopsed
>> too, if it had called fallback_alloc() this early.  So presumably it did
>> not.  But yours does.  I wonder why?
> 
> Hmmm... Fallback during boot? Any zones that have no ZONE_NORMAL memory?

I think there is some kind of memory layout issue with the machine (see
my reply to akpm), which I'll look into tommorrow.  But as the machine
is tripping this bug, I'll throw this patch at it also.

-apw
