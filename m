Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267819AbUIMPUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267819AbUIMPUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUIMPRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:17:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267819AbUIMPNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:13:06 -0400
Subject: Re: journal aborted, system read-only
From: "Stephen C. Tweedie" <sct@redhat.com>
To: gene.heskett@verizon.net
Cc: Stephen Tweedie <sct@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409121128.39947.gene.heskett@verizon.net>
References: <200409121128.39947.gene.heskett@verizon.net>
Content-Type: text/plain
Organization: 
Message-Id: <1095088378.2765.18.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Sep 2004 16:12:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2004-09-12 at 16:28, Gene Heskett wrote:

> I just got up, and found advisories on every shell open that the 
> journal had encountered an error and aborted, converting my / 
> partition to read-only.
...
> The kernel is 2.6.9-rc1-mm4.  .config available on request.

> This is precious little info to go on, but basicly I'm wondering if 
> anyone else has encountered this?

Well, we really need to see _what_ error the journal had encountered to
be able to even begin to diagnose it.  But 2.6.9-rc1-mm3 and -mm4 had a
bug in the journaling introduced by low-latency work on the checkpoint
code; can you try -mm5 or back out
"journal_clean_checkpoint_list-latency-fix.patch" and try again?

Cheers,
 Stephen


