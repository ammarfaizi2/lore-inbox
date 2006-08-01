Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWHATPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWHATPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWHATPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:15:40 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:28849 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751819AbWHATPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:15:37 -0400
X-IronPort-AV: i="4.07,203,1151910000"; 
   d="scan'208"; a="1843417399:sNHT32197068"
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: use persistent allocation for cursor blinking.
X-Message-Flag: Warning: May contain useful information
References: <20060801185618.GS22240@redhat.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 01 Aug 2006 12:15:35 -0700
In-Reply-To: <20060801185618.GS22240@redhat.com> (Dave Jones's message of "Tue, 1 Aug 2006 14:56:18 -0400")
Message-ID: <adairlc5ktk.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Aug 2006 19:15:36.0480 (UTC) FILETIME=[DE3F7A00:01C6B59E]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Every time the console cursor blinks, we do a kmalloc/kfree pair.
 > This patch turns that into a single allocation.

A naive question from someone who knows nothing about this subsystem:
is there any possibility of concurrent calls into this function, for
example if there are multiple cursors on a multiheaded system?

 - R.
