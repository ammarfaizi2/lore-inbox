Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVJ3OtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVJ3OtE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJ3OtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:49:04 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:33676 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1750709AbVJ3OtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:49:01 -0500
Date: Sun, 30 Oct 2005 15:48:57 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030144857.GA23438@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	"Steinar H. Gunderson" <sgunderson@bigfoot.com>,
	linux-kernel@vger.kernel.org
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl> <20051030104527.GB32446@uio.no> <20051030110021.GA19680@outpost.ds9a.nl> <20051030113651.GA1780@uio.no> <20051030114537.GA20564@outpost.ds9a.nl> <20051030142223.GA12146@uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030142223.GA12146@uio.no>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 03:22:23PM +0100, Steinar H. Gunderson wrote:

> I've compiled some extra debugging code (printing the msg_hdr structure if
> recvmsg() should fail with a hard error) into named, so I'm waiting for the
> problem to manifest itself again.

Sounds like a wise move, the msg_hdr structure again contains pointers which
might point to invalid memory.

What you could try to do is master git and get it to output a diff of
relevant files from your previous version to 2.6.14. Sadly, that might be a
lot of files.. If you start tracing from udp_recvmsg you quickly end up in a
heap of files which might be generating EFAULT.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
