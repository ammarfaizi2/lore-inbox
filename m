Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTJGNyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTJGNyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:54:54 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50483 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262190AbTJGNyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:54:53 -0400
Date: Tue, 7 Oct 2003 14:54:17 +0100
From: Dave Jones <davej@redhat.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: changes to microcode update driver.
Message-ID: <20031007135417.GC11840@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 03:58:00AM -0700, Tigran Aivazian wrote:
 > Hi guys,
 > 
 > It's been a long time that I was going to send to Linux the patch with the
 > following changes, but the birth of my first child intervened and caused
 > delays (though can't call them "unexpected" :)

Congrats 8-)

 > 1. Remove ->read() method for /dev/cpu/microcode device node and do not
 > hold a copy of applied microcode chunks in kernel memory. In the days when
 > we had a regular devfs file with a non-zero size this had at least some
 > potential use but now this feature is almost useless and removing it would
 > allow a lot of code cleanup and simplification.
 > 
 > 2. remove MICROCODE_IOCFREE ioctl for freeing the copy of held microcode
 > (because there won't be such copy, see 1.)

Assuming that it can be done without the old tools breaking, sounds good
to me.  How will microcode_ctl -i react if you remove the ioctl ?
Folks _will_ upgrade kernels without updating userspace.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
