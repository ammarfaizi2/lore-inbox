Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbTIPXpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTIPXpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:45:43 -0400
Received: from ns.suse.de ([195.135.220.2]:18832 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262576AbTIPXpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:45:41 -0400
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Options for handling  buggy PCI/PCI-X hardware when MSI is enabled
References: <7F740D512C7C1046AB53446D3720017304AF60@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Sep 2003 01:45:38 +0200
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AF60@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
Message-ID: <p73ekygnvq5.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nakajima, Jun" <jun.nakajima@intel.com> writes:

> "Blacklist" approach using PCI_quirks.c
> ---------------------------------------
> Pros
>    - Places the burden to fix broken HW on the HW owners
>    - Consistent with the current MSI patch (enable all by default)
>    - A simple fix and minimum patch size (Patch already exists)
> Cons
>    - Core kernel impact (larger image size)

And worse one has to submit patches for the core kernel all the time.
And it's a single table, which means there will be lots of conflicts 
when merging patches.

I think the new API approach is much better. Best would be if there
was a relatively simple standard way to add it to drivers  (like a 
standard module option). Then one could add it to a lot of drivers 
with default to off. Users can test then and if it works the default
can be changed.

-Andi
