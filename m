Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWARQsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWARQsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWARQsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:48:05 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:34311
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030343AbWARQsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:48:04 -0500
Message-Id: <43CE7F58.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 18 Jan 2006 17:48:08 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <tony.luck@intel.com>, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Andrew Morton" <akpm@osdl.org>, "Paul Mackerras" <paulus@samba.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
References: <4370AF4A.76F0.0078.0@novell.com>  <20060118151816.GA82365@muc.de>  <43CE73A0.76F0.0078.0@novell.com> <200601181711.47163.ak@suse.de>
In-Reply-To: <200601181711.47163.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The usual use case is that you only need it on disk for your gdb,
>but not in RAM.

If you care about gdb, you'd be building with CONFIG_DEBUG_INFO anyway, and get the same information in .debug_frames
(which already is a noload section) without the need to enable CONFIG_UNWIND_INFO.

Jan


