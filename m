Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTKZJ6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 04:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbTKZJ6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 04:58:40 -0500
Received: from holomorphy.com ([199.26.172.102]:8893 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264113AbTKZJ6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 04:58:39 -0500
Date: Wed, 26 Nov 2003 01:58:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tim Connors <tconnors+linuxkernel1069831506@astro.swin.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
Message-ID: <20031126095832.GI8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tim Connors <tconnors+linuxkernel1069831506@astro.swin.edu.au>,
	linux-kernel@vger.kernel.org
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos> <slrn-0.9.7.4-9248-27858-200311261825-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn-0.9.7.4-9248-27858-200311261825-tc@hexane.ssi.swin.edu.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 06:31:37PM +1100, Tim Connors wrote:
> Hence 2 should be the default. 
> 0 should be left for those poor fools who run closed source software,
> and can't get their vendor to fix their bugs, so need to use some
> kernel kludges (ie, overcommit) to get around it.

This suggestion has two rather large problems:

(a) Non-overcommit is a useful reliability feature: the VM guarantees
	(well, with 99% probability) it will not be forced to randomly
	kill processes, but instead return -ENOMEM when there isn't
	enough memory.

(b) Once overcommit is enabled, it can't be reliably disabled.


-- wli
