Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTJQTEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJQTEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:04:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51400 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263585AbTJQTER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:04:17 -0400
Subject: Re: 2.6.0-test7-mm1 4G/4G hanging at boot
From: Paul Larson <plars@linuxtestproject.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20031017111955.439d01c8.rddunlap@osdl.org>
References: <20031017111955.439d01c8.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Oct 2003 14:03:44 -0500
Message-Id: <1066417426.19236.3316.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 13:19, Randy.Dunlap wrote:
> I'm seeing this at boot:
> 
> Checking if this processor honours the WP bit even in supervisor mode...
> 
> then I wait for 1-2 minutes and hit the power button.
> This is on an IBM dual-proc P4 (non-HT) with 1 GB of RAM.
> 
> Has anyone else seen this?  Suggestions or fixes?
> 
This was a problem a while back with a bad check fixed by this patch:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/broken-out/4g4g-do_page_fault-cleanup.patch
I can't seem to find that it slipped back in anywhere but the problem
sounds identical (minus an error message about invalid kernel-mode
pagefault before).

-Paul Larson


