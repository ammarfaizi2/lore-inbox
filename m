Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUHAPIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUHAPIy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 11:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUHAPIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 11:08:54 -0400
Received: from holomorphy.com ([207.189.100.168]:53414 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266009AbUHAPIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 11:08:52 -0400
Date: Sun, 1 Aug 2004 08:05:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-ID: <20040801150537.GW2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com> <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com> <20040801124053.GS2334@holomorphy.com> <Pine.LNX.4.58.0408011052090.4095@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408011052090.4095@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, William Lee Irwin III wrote:
>> Maybe the few callers that are sensitive to the precise return value
>> should use min_t(int, NR_CPUS, ...) instead of all callers taking the
>> branch on behalf of those few.

On Sun, Aug 01, 2004 at 10:54:03AM -0400, Zwane Mwaikambo wrote:
> The problem is that next_cpu(0) will assign the incorrect value of '32'
> to variable cpu so when you exit the loop, you'll have some silly number.
> This really should be covered in the API, especially since that's what the
> API states is the expected behaviour.

I see. AFAICT this can also be dealt with by the caller and is far less
common than total insensitivity to which value >= NR_CPUS is involved.


-- wli
