Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWGZS7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWGZS7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWGZS7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:59:13 -0400
Received: from mail.suse.de ([195.135.220.2]:29840 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751761AbWGZS7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:59:11 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Date: Wed, 26 Jul 2006 20:53:40 +0200
User-Agent: KMail/1.9.3
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       "Gulam, Nagib" <nagib.gulam@amd.com>, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
References: <84EA05E2CA77634C82730353CBE3A84303218F09@SAUSEXMB1.amd.com>
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84303218F09@SAUSEXMB1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607262053.40123.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In contrast, the same machine running with TSC and standard
> PN! sees massive drift, upwards of an hour, within an hour.

Do you see the same drift when you lock date on a single CPU
with taskset?

> If the TSCnow! patch reduces measured drift down to a second 
> a week, would you consider that acceptable?

No because even one second a week will break timing badly
over time. 

I believe the only good solution unless hardware helps would
be to use per CPU TSC offsets as discussed earlier. Even that
is a bit risky because there can be still very small drifts,
but they should be limited by a clock tick error max and
might work out.

-Andi

