Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265801AbUF2Qcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUF2Qcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbUF2Qcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:32:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:17841 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265801AbUF2Qcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:32:41 -0400
Date: Tue, 29 Jun 2004 09:32:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
Message-Id: <20040629093234.459c46c6@dell_ss3.pdx.osdl.net>
In-Reply-To: <40E0EAC1.50101@redhat.com>
References: <40E0EAC1.50101@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 21:06:25 -0700
Ulrich Drepper <drepper@redhat.com> wrote:

> POSIX does not specify the if_indextoname and if_nameindex functions,
> they are only vaguely specified in an RFC.  So there is some room for
> interpretation but still I think it is an issue.
> 
> If SIOCGIFCONF to query the system's interfaces only active interfaces
> are returned.  But SIOCGIFNAME (and SIOCGIFINDEX) allow querying
> interfaces which are down and not fully initialized.
> 
> RFC 3493 says if_nameindex should return *all* interfaces.  This means
> that neither if_indextoname or if_nametoindex (defined in the same rfc)
> should define more interfaces.
> 

The bridge utilities depends on being able to do if_indextoname and
if_nametoindex for interfaces that aren't active to IP.  Other non-IP
usage probably does as well.

-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
