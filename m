Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbSLDJSS>; Wed, 4 Dec 2002 04:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSLDJSR>; Wed, 4 Dec 2002 04:18:17 -0500
Received: from holomorphy.com ([66.224.33.161]:53635 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266967AbSLDJSQ>;
	Wed, 4 Dec 2002 04:18:16 -0500
Date: Wed, 4 Dec 2002 01:25:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021204092541.GB9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Christoph Hellwig <hch@sgi.com>,
	marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
	linux-kernel@vger.kernel.org
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <20021204000618.GG11730@dualathlon.random> <3DED4CA4.5B9A20EA@digeo.com> <20021204004234.GL11730@dualathlon.random> <20021204010307.GA9882@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204010307.GA9882@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 04:30:28PM -0800, Andrew Morton wrote:
>>> load is just one or more busywaits.  It has to be a compilation.  It
>>> could be something to do with all the short-lived processes, or gcc -pipe)

On Wed, Dec 04, 2002 at 01:42:34AM +0100, Andrea Arcangeli wrote:
>> could be that we think they're very interactive or something like that.

On Tue, Dec 03, 2002 at 05:03:07PM -0800, William Lee Irwin III wrote:
> The pipe issue is observable without involving gcc or kernel compiles.
> Cooperating processes are consistently granted excessive priorities.

More specifically, the "cooperating processes monopolize the cpu"
scenario is at its worst when a shell script is used to drive the bochs
simulator by single-stepping in order to generate instruction-level
boot-time traces of the execution of custom executives.

./foo.sh | bochs is the method, where the contents of foo.sh are
trivially derivable from bochs' debugging interface (a couple of
newlines and then repeating 's' indefinitely, then killing the process
by hand when the exception is observed while tail -f'ing the trace).


Bill
