Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270837AbTGPOCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270838AbTGPOCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:02:24 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:32772 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S270837AbTGPOCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:02:23 -0400
Date: Wed, 16 Jul 2003 15:17:38 +0100
From: Joe Thornber <thornber@sistina.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: LVM2 user space, device mapper, Linux 2.4/2.6 dual boot no-go.
Message-ID: <20030716141738.GF369@fib011235813.fsnet.co.uk>
References: <20030716095321.GF27177@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716095321.GF27177@merlin.emma.line.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 11:53:21AM +0200, Matthias Andree wrote:
> I want to test drive 2.6, have 2.4.22-pre3-ac1 with LVM1, Device Mapper
> and XFS. I tried LVM2 user space on 2.4.22, it complained about ioctl
> mismatch (wants 4.x.y, gets 1.m.n). Do I need to disable LVM1?

The latest tools should work with both v1 and v4 ioctl interfaces,
though there will be an error message when the tools fallback from v4
to v1.

I submitted v4 patches for 2.5 last friday but sadly they haven't been
merged yet.  If you apply these patches you will have to explicitly
enable the v4 interface with 'make config'.

I run the same tools aginst 2.4.21 (v4) 2.5.75 (v1) and 2.5.75 (v4).

- Joe
