Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbTCQMiV>; Mon, 17 Mar 2003 07:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCQMiV>; Mon, 17 Mar 2003 07:38:21 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:27022 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261651AbTCQMiU>; Mon, 17 Mar 2003 07:38:20 -0500
Date: Mon, 17 Mar 2003 12:46:41 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Heinz Ulrich Stille <hus@design-d.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read Hat 7.3 and 8.0 compilation problems
Message-ID: <20030317134635.GA436@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Heinz Ulrich Stille <hus@design-d.de>, linux-kernel@vger.kernel.org
References: <001d01c2ec83$6bfbcc10$e9bba5cc@patni.com> <200303171332.34982.hus@design-d.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303171332.34982.hus@design-d.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 01:32:33PM +0100, Heinz Ulrich Stille wrote:

 > Are you using the stock rh kernel sources? Did you install the
 > glibc-kernheaders RPM? This contains severe RedHat braindamage:
 > /usr/include/{asm,linux} aren't links into the kernel source tree,
 > but directly installed. Remove the rpm and create the soft links
 > to /usr/src/linux.

You have this completely backwards. /usr/include/{asm,linux} are
the headers from the kernel that the glibc was compiled against.
They should NOT never ever be symlinks to anywhere, but glibc's
own copies of the headers.

This is not 'RedHat braindamage', it's the way things should be.
Making them symlinks is the only braindamage here.

		Dave

