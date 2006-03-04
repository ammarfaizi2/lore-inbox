Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWCDAIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWCDAIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWCDAIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:08:54 -0500
Received: from cantor2.suse.de ([195.135.220.15]:62881 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751721AbWCDAIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:08:54 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Sat, 4 Mar 2006 01:08:40 +0100
User-Agent: KMail/1.8
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Lee Revell <rlrevell@joe-job.com>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <20060303234330.GA14401@ti64.telemetry-investments.com> <4408D55F.4090105@garzik.org>
In-Reply-To: <4408D55F.4090105@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603040108.41490.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 March 2006 00:46, Jeff Garzik wrote:
>  More likely is a disabled interrupt period is longer than a
> tick period, or similar.

Then the ticks wouldn't be attributed to idle and softirq.
They are both special in that they do an unconditional local_irq_enable()
instead of the usual save/restore.

-Andi
