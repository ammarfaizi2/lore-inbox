Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUG2Njw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUG2Njw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUG2Njw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:39:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264643AbUG2Njs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:39:48 -0400
Date: Thu, 29 Jul 2004 09:39:03 -0400
From: Alan Cox <alan@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fix ide probe double detection
Message-ID: <20040729133903.GA12406@devserv.devel.redhat.com>
References: <20040727224629.GA17147@devserv.devel.redhat.com> <1091071364.13625.37.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091071364.13625.37.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 01:22:44PM +1000, Benjamin Herrenschmidt wrote:
> I don't like relying on drive->id and serial_no, but that may just be
> paranoia...

I've seen no evidence to indicate anyone has duplicate serial numbers
even with CF cards so I think its fine. The problem with playing with
registers and seeing if they stick is that on the newer cards the
register bank you are programming is sometimes a fifo ahead of the real
drive.

Alan
