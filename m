Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTIEXyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTIEXyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:54:32 -0400
Received: from vitelus.com ([64.81.243.207]:43727 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S264015AbTIEXyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:54:32 -0400
Date: Fri, 5 Sep 2003 16:51:21 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030905235121.GB2743@vitelus.com>
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr> <200309042257.12739.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309042257.12739.mhf@linuxmail.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:57:12PM +0800, Michael Frank wrote:
> As to using assembler, It is better to get rid of it but in special cases.
> Todays compilers are the better coders in 98+% of applications

This has already been shot down pretty well but a good example of why
it's not true is George Woltman's prime95 (mprime on linux) program.
The core is an FFT which has been painfully rewriten several times for
different cores to maximize performance. It makes extensive use of
SSE2 on the P4, which I haven't seen compilers do much of. George is a
great coder and he's pipelined everything so well that there really
isn't much room for improvement. This assembly is several times faster
than what gcc would be able to generate.
