Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTKZCIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTKZCIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:08:53 -0500
Received: from holomorphy.com ([199.26.172.102]:29116 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263898AbTKZCIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:08:52 -0500
Date: Tue, 25 Nov 2003 18:08:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Petersen <Chris.Petersen@synopsys.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: PROBLEM:  Blk Dev Cache causing kswapd thrashing
Message-ID: <20031126020846.GE8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Petersen <Chris.Petersen@synopsys.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <3FC3C3BC.CAEC23CA@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC3C3BC.CAEC23CA@synopsys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 04:03:56PM -0500, Chris Petersen wrote:
> The block device cache is causing kswapd thrashing, usually bringing
> the system to a halt.
> This problem has been reproduced on kernels as recent as 2.4.21.
> In our application we deal with large (multi-GB) files on multi-CPU
> 4GB platforms.  While handling these files, the block device cache
> allocates all remaining available memory (3.5G) up to the 4G
> physical limit.

Please try 2.4.23-rc5, and if that doesn't fix it, try 2.6.0-test10.
AIUI both have page replacement improvements over 2.4.21.


-- wli
