Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTFEJA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTFEJA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:00:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28168 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264533AbTFEJAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:00:24 -0400
Date: Thu, 5 Jun 2003 10:13:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Frank Cusack <fcusack@fcusack.com>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
Message-ID: <20030605101351.C960@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Cox <adrian@humboldt.co.uk>,
	Frank Cusack <fcusack@fcusack.com>, trond.myklebust@fys.uio.no,
	linux-kernel@vger.kernel.org
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <20030605101120.2bea125a.adrian@humboldt.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030605101120.2bea125a.adrian@humboldt.co.uk>; from adrian@humboldt.co.uk on Thu, Jun 05, 2003 at 10:11:20AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:11:20AM +0100, Adrian Cox wrote:
> There's a very common cause on embedded boards that don't have
> real-time clocks. Without a clock the client uses the same XID on every
> run, leading to lots of these messages. Is your clock broken?

BTDT.

If this is the case, you need to ensure that you don't reboot the client
before the servers XID cache times out the XID numbers.  For Linux knfsd,
that's around 2 minutes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

