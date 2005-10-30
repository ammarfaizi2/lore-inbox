Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVJ3Lpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVJ3Lpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 06:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVJ3Lpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 06:45:41 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:46466 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932096AbVJ3Lpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 06:45:41 -0500
Date: Sun, 30 Oct 2005 12:45:38 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030114537.GA20564@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	"Steinar H. Gunderson" <sgunderson@bigfoot.com>,
	linux-kernel@vger.kernel.org
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl> <20051030104527.GB32446@uio.no> <20051030110021.GA19680@outpost.ds9a.nl> <20051030113651.GA1780@uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030113651.GA1780@uio.no>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:36:51PM +0100, Steinar H. Gunderson wrote:
>   [pid 13365] recvmsg(22, 0x561329b0, 0)  = -1 EFAULT (Bad address)
> 
> Might this be a BIND bug instead? In that case, why doesn't it show up with
> 2.6.11.9? I've restarted BIND now without NPTL, to see if it might be
> thread-related.

Check if the address passed, 0x561329b0, is very different from addresses
passed during regular operations. The error the kernel returns basically
says that this address is bogus, which it might be, but if more or less the
same address worked previously chances are that the kernel is confused

Switching to/from NPTL might very well change the address btw.

Good luck.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
