Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932780AbWAKC1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbWAKC1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbWAKC1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:27:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932780AbWAKC1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:27:07 -0500
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Keith Owens <kaos@sgi.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres
References: <Pine.LNX.4.58.0601101606380.12724@shark.he.net>
	<20396.1136939008@ocs3.ocs.com.au>
	<20060110163956.A17329@unix-os.sc.intel.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 10 Jan 2006 21:26:37 -0500
In-Reply-To: <20060110163956.A17329@unix-os.sc.intel.com>
Message-ID: <y0mvewr4i02.fsf@tooth.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


anil.s.keshavamurthy@intel.com writes:

> [...]  Humm..This duplication of symbols in the kernel will be a
> problem for systemtap scripts, as we might end up putting probes in
> the unwanted places :-( [...]

Not at all.  Systemtap does not look in System.map.  It can qualify
function names with the compilation unit name to make unique the probe
target.  For that matter, it only uses /proc/kallsyms as a table to
drive the address-to-name mappings in debug output.

- FChE
