Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269023AbUIHDgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269023AbUIHDgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269024AbUIHDgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:36:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10149 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269023AbUIHDg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:36:28 -0400
Date: Wed, 8 Sep 2004 04:36:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dawson Engler <engler@coverity.dreamhost.com>
Cc: linux-kernel@vger.kernel.org, developers@coverity.com
Subject: Re: [CHECKER] possible reiserfs deadlock in 2.6.8.1
Message-ID: <20040908033628.GV23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409072016090.12274@coverity.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409072016090.12274@coverity.dreamhost.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 08:16:53PM -0700, Dawson Engler wrote:
> Hi All,
> 
> below is a possible deadlock in the linux-2.6.8.1 reiserfs code found by
> a static deadlock checker I'm writing.  Let me know if it looks valid
> and/or whether the output is too cryptic.    Note, one of the locks is
> through a struct pointer, so the deadlock depends on both acquisitions
> being to the same struct.

Not valid, for the same reason as the above.  BKL and down() do not form
a mutual deadlock.
