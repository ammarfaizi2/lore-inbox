Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSKKHjA>; Mon, 11 Nov 2002 02:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSKKHjA>; Mon, 11 Nov 2002 02:39:00 -0500
Received: from holomorphy.com ([66.224.33.161]:65460 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265647AbSKKHi7>;
	Mon, 11 Nov 2002 02:38:59 -0500
Date: Sun, 10 Nov 2002 23:43:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021111074317.GL23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <200211110437.gAB4bPl390685@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211110437.gAB4bPl390685@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 08:58:28AM -0800, Andrew Morton wrote:
>> It could be the procps thing?  `tiobench --threads 256' shows
>> up as a single process in top and ps due to the new thread
>> consolidation feature. If you run `ps auxm' or hit 'H' in top,
>> all is revealed.  Not my fave feature that.

On Sun, Nov 10, 2002 at 11:37:25PM -0500, Albert D. Cahalan wrote:
> The feature is both buggy (both false consolidation and failure
> to consolidate) and slow. While I do eventually need to add the
> feature, I'm not doing so until it can be implemented properly.
> So go ahead and enjoy procps-3.1.0 without it:

This is not caused by userspace. This is a direct consequence of the
quadratic get_pid_list().


Bill
