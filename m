Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVB1XjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVB1XjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVB1XjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:39:10 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:14766 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261819AbVB1Xi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:38:59 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] PCI bridge driver rewrite
Date: Mon, 28 Feb 2005 15:38:18 -0800
User-Agent: KMail/1.7.2
Cc: Jon Smirl <jonsmirl@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <1109226122.28403.44.camel@localhost.localdomain> <200502241502.15163.jbarnes@sgi.com> <1109633268.28403.77.camel@localhost.localdomain>
In-Reply-To: <1109633268.28403.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502281538.18881.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 28, 2005 3:27 pm, Adam Belay wrote:
> How can we specify which bus to target?

Maybe we could have a list of legacy (ISA?) devices for drivers like vgacon to 
attach to?  The bus info could be stuffed into the legacy device structure 
itself so that the platform code would know what to do.

> Also is the legacy IO space mapped to IO Memory on the other side of the
> bridge?

How do you mean?  Legacy I/O port accesses just become strongly ordered memory 
transactions, afaik, and legacy memory accesses are dealt with the same way.

Jesse
