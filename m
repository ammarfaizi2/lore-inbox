Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTDFVYj (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbTDFVYj (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:24:39 -0400
Received: from holomorphy.com ([66.224.33.161]:9116 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263103AbTDFVYh (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:24:37 -0400
Date: Sun, 6 Apr 2003 14:35:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406213537.GO993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
	dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com> <20030405220621.GG1326@dualathlon.random> <20030405143138.27003289.akpm@digeo.com> <20030405231008.GI1326@dualathlon.random> <20030405175824.316efe90.akpm@digeo.com> <20030406144734.GN1326@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406144734.GN1326@dualathlon.random>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>>> Esepcially those sigbus in the current api
>>> would be more expensive than the regular paging internal to the VM and
>>> besides the signal it would generate flood of syscalls and kind of
>>> duplication of memory management inside the userspace.

On Sat, Apr 05, 2003 at 05:58:24PM -0800, Andrew Morton wrote:
>> That went away.  We now encode the file offset in the unmapped ptes, so the
>> kernel's fault handler can transparently reestablish the page.

On Sun, Apr 06, 2003 at 04:47:34PM +0200, Andrea Arcangeli wrote:
> if you put the file offset in the pte, you will break the max file
> offset that you can map, that at least should be recoded with a cookie
> like we do with the swap space

IIRC we just restricted the size of the file that can use the things to
avoid having to code quite so much up.


-- wli
