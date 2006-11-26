Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935221AbWKZBZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935221AbWKZBZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935220AbWKZBZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:25:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:12994 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S935221AbWKZBZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:25:14 -0500
Date: Sun, 26 Nov 2006 01:25:11 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roland Dreier <rdreier@cisco.com>
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
Message-ID: <20061126012511.GS3078@ftp.linux.org.uk>
References: <adazmag5bk1.fsf@cisco.com> <20061124.220746.57445336.davem@davemloft.net> <adaodqv5e5l.fsf@cisco.com> <20061125.150500.14841768.davem@davemloft.net> <20061126011014.GR3078@ftp.linux.org.uk> <adaslg73t2j.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaslg73t2j.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 05:17:08PM -0800, Roland Dreier wrote:
>  > 	(typeof(x))((x + a - 1) & ~(a - 1ULL))
> 
> Yes I was being stupid thinking I needed a temporary variable to use
> typeof.  But what does the cast to typeof(x) accomplish if we write
> things the way you suggested above?  It seems that the right things is
> really just
> 
> 	(((x) + (a) - 1) & ~((typeof(x)) (a) - 1))

Better have type of result independent of that of a.
