Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUDAWqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbUDAWqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:46:42 -0500
Received: from mirapoint2.TIS.CWRU.Edu ([129.22.104.47]:36907 "EHLO
	mirapoint2.tis.cwru.edu") by vger.kernel.org with ESMTP
	id S263137AbUDAWqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:46:40 -0500
To: Joe Buck <Joe.Buck@synopsys.COM>
Cc: Andi Kleen <ak@suse.de>,
       Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
In-Reply-To: <20040401143908.B4619@synopsys.com> (Joe Buck's message of
 "Thu, 1 Apr 2004 14:39:08 -0800")
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de>
	<20040401203923.GA32177@nevyn.them.org>
	<20040401143908.B4619@synopsys.com>
From: prj@po.cwru.edu (Paul Jarc)
Organization: What did you have in mind?  A short, blunt, human pyramid?
Mail-Copies-To: nobody
Mail-Followup-To: Joe Buck <Joe.Buck@synopsys.COM>, Andi Kleen <ak@suse.de>,
 Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>, gcc@gcc.gnu.org, 
 linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Date: Thu, 01 Apr 2004 17:44:59 -0500
Message-ID: <m3ad1vjp1a.fsf@multivac.cwru.edu>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Buck <Joe.Buck@synopsys.COM> wrote:
> Case 2: make falsely thinks that the .c is younger than the .o.  It
> recompiles the .c file, even though it didn't have to.  Harmless.

The OP explained how this can be harmful in the case of parallel
builds - the .o file is not updated atomically, so while one part of
the build is (unnecessarily) updating it, another part will fail to
find it.


paul
