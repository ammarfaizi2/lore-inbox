Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWALSgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWALSgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWALSgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:36:35 -0500
Received: from kanga.kvack.org ([66.96.29.28]:42897 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932642AbWALSge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:36:34 -0500
Date: Thu, 12 Jan 2006 13:32:40 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: need for packed attribute
Message-ID: <20060112183239.GA6096@kvack.org>
References: <200601061915.43961.oliver@neukum.org> <20060106183846.GF16093@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106183846.GF16093@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:38:46PM +0000, Russell King wrote:
> > /* All standard descriptors have these 2 fields at the beginning */
> > struct usb_descriptor_header {
> > 	__u8  bLength;
> > 	__u8  bDescriptorType;
> > };
> 
> sizeof(struct usb_descriptor_header) will be 4 on ARM.  If this
> concerns you, you need to pack the structure thusly:

Interesting.  Perhaps we should add -Wpadded to CFLAGS in order to remind 
people, although that might take a fair bit of work to clean up existing 
structure definitions.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
