Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278391AbRJZL3D>; Fri, 26 Oct 2001 07:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRJZL2y>; Fri, 26 Oct 2001 07:28:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26961 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278391AbRJZL2i>; Fri, 26 Oct 2001 07:28:38 -0400
Date: Fri, 26 Oct 2001 13:29:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Ahna <christopher.j.ahna@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid a race in complete_change_console()
Message-ID: <20011026132908.C30905@athlon.random>
In-Reply-To: <20011025210744.A17499@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011025210744.A17499@intel.com>; from christopher.j.ahna@intel.com on Thu, Oct 25, 2001 at 09:07:44PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 09:07:44PM -0700, Chris Ahna wrote:
> Can someone familiar with this code comment on the correctness of this
> patch?  The patch is against vanilla 2.4.13.  Thanks,

I'm not very familiar with it, but it seems sane fix. Only detail is
that the vc_mode can only be KD_TEXT after the reset_vc but the
additional check doesn't hurt and it makes it indipendent by the
reset_vc details.

Andrea
