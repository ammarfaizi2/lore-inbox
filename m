Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbULIUJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbULIUJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULIUJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:09:02 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:33165 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261599AbULIUI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:08:58 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][AGPGART]Allow multiple backends to be initialized
Date: Thu, 9 Dec 2004 12:10:32 -0800
User-Agent: KMail/1.6.2
References: <200412061740.52337.werner@sgi.com> <20041207090244.GA13591@infradead.org>
In-Reply-To: <20041207090244.GA13591@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412091210.32917.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 December 2004 01:02, Christoph Hellwig wrote:
> Wrong interface.  Please pass in the pci_dev of the grpahics cards and
> add a new method for lowlevel drivers to find the bridge.  For the normal
> bridges (aka everything but the hp, alpha and your new driver) you'd do
> a generic helper that just walks down the parent pointers until it finds
> a class.
> 
how do you want to handle the frontend driver?

> Also I'd suggest returning the found bridges as return value of the
> function.
> 
How should the caller distinguish between
a real error and the bridge in use by another client?
