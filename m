Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271351AbTGQINt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271354AbTGQINt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:13:49 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:26595 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S271351AbTGQINs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:13:48 -0400
Date: Thu, 17 Jul 2003 01:27:17 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717082716.GA19891@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl> <20030716152143.6ab7d7d3.akpm@osdl.org> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716164917.2a7a46f4.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 04:49:17PM -0700, Andrew Morton wrote:
> Please describe a scenario in which a filesystem which works on current
> kernels will, in a 64-bit-dev_t kernel, call init_special_inode() with a
> 16:16 encoded device number.

	Perhaps he's thinking of NFSv2.  If you want to make a device
bigger than 8:8...  Personally, I'm happy to ignore NFSv2 for this.
	If we did support a 32bit median format, I would suggest we
either use Peter's strategy or we use 12:20.  16:16 is so limiting.

Joel


-- 

"War doesn't determine who's right; war determines who's left."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
