Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVAOKHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVAOKHY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 05:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAOKHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 05:07:24 -0500
Received: from holomorphy.com ([66.93.40.71]:32985 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262252AbVAOKHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 05:07:19 -0500
Date: Sat, 15 Jan 2005 02:07:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, matthias@corelatus.se,
       linux-kernel@vger.kernel.org
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
Message-ID: <20050115100709.GJ3474@holomorphy.com>
References: <16872.55357.771948.196757@antilipe.corelatus.se> <20050115013013.1b3af366.akpm@osdl.org> <20050115093657.GI3474@holomorphy.com> <1105783125.6300.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105783125.6300.32.camel@laptopd505.fenrus.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 01:36 -0800, William Lee Irwin III wrote:
>> We can easily do a "rolling upgrade" by adding new versions of the
>> system calls, giving glibc and apps grace periods to adjust to them,
>> and nuking the old versions in a few years.

On Sat, Jan 15, 2005 at 10:58:45AM +0100, Arjan van de Ven wrote:
> but for 1: do we care? it is being more tolerant than allowed by a
> standard. Those who care can easily add the test in the userspace
> wrapper
> for 2: we again are more tolerant and dtrt; again. And again userspace
> wrapper can impose an additional restriction if it wants
> 3 is more nasty and needs thinking; we could consider a fix inside the
> kernel that actually does wait long enough
> I don't see a valid reason to restrict/reject input that is accepted now
> and dealt with reasonably because some standard says so (if you design a
> new api, following the standard is nice of course). I don't see "doesn't
> reject a condition that can reasonable be dealt with" as a good reason
> to go double ABI at all.

These are probably better reasons against fiddling with ABI shifts and
against starting 2.7 for its sake than I could come up with. Thanks.

-- wli
