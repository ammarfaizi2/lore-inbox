Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271352AbTGQJAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271350AbTGQJAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:00:42 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:9941 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id S271355AbTGQJAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:00:39 -0400
Date: Thu, 17 Jul 2003 02:15:15 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717091515.GC19891@ca-server1.us.oracle.com>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Andrew Morton <akpm@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
	greg@kroah.com, linux-kernel@vger.kernel.org
References: <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl> <20030716152143.6ab7d7d3.akpm@osdl.org> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717082716.GA19891@ca-server1.us.oracle.com> <Pine.LNX.4.44.0307171037070.717-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307171037070.717-100000@serv>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 10:47:08AM +0200, Roman Zippel wrote:
> It's not just NFS2, with NFS3 and later it also depends on how many and 
> which bits the server keeps. They usually use the standard major/minor/ 
> makedev macros, so you only get back what the platform supports.
> Splitting dev_t in major/minor numbers can be lots of fun...

	Well, exporting devices over NFS is always tricky, because if
the server isn't an identical OS, you can't even trust the numbers.  As
you point out, you get the platform's idea of a device number, and that
doesn't map to your local OS.
	It is no different than today.  You have to make sure that the
server's filesystem stores device numbers valid for the client if the
client wants to use those device nodes.

Joel


-- 

"In the room the women come and go
 Talking of Michaelangelo."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
