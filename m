Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTKRAAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTKRAA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:00:29 -0500
Received: from holomorphy.com ([199.26.172.102]:26533 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262221AbTKRAAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:00:25 -0500
Date: Mon, 17 Nov 2003 16:00:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: format_cpumask()
Message-ID: <20031118000021.GF22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B8@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B8@scsmsx401.sc.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I was trying to make it a NR_CPUS -bit integer with the 
>> highest nybbles
>> printed first. What's your favorite alternative?

On Mon, Nov 17, 2003 at 03:56:34PM -0800, Luck, Tony wrote:
> The prettiest output format I can think of would be
> to pretend that we had enough bits for NR_CPUS.  I.e.
> on a 128 cpu system, cpu0 looks like:
>  00000000000000000000000000000001
> and cpu 127 is:
>  80000000000000000000000000000000
> This is probably the messiest to implement :-(
> -Tony

This is actually what I was trying to do. It's why I started the
loop of printing out the hexadecimal unsigned long components with
for (k = sizeof(cpumask_t)/sizeof(long) - 1; k >= 0; --k);

except I posted ++k. Amended patch coming very shortly.


-- wli
