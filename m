Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTKQXfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKQXfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:35:50 -0500
Received: from holomorphy.com ([199.26.172.102]:24229 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262072AbTKQXft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:35:49 -0500
Date: Mon, 17 Nov 2003 15:35:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: format_cpumask()
Message-ID: <20031117233542.GE22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B0@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B0@scsmsx401.sc.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 10:49:31AM -0800, Luck, Tony wrote:
> That makes it had to write portable shell scripts (etc.) that can
> parse these values on both 32-bit and 64-bit systems?  A bitmask with
> just cpu0 set looks like:
> 	0000000100000000
> on a 32-bit machine.  And like:
> 	0000000000000001
> on a 64-bit machine.  Heaven help the architectures (ia64, sparc, ppc)
> that support both 32-bit and 64-bit applications!

Okay, so we need to:

(a) zero-pad the 64-bit case
(b) pick a format the users actually like

I was trying to make it a NR_CPUS -bit integer with the highest nybbles
printed first. What's your favorite alternative?


-- wli
