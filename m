Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUG1SHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUG1SHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUG1SHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:07:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51434 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261405AbUG1SHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:07:15 -0400
Date: Wed, 28 Jul 2004 19:07:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-ID: <20040728180713.GI12308@parcelfarce.linux.theplanet.co.uk>
References: <20040727201301.2723f5ad.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727201301.2723f5ad.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 08:13:01PM -0700, David S. Miller wrote:
 
> I was about to make sparc64 specific copies of all the stat
> system calls in order to optimize this properly.  But that
> makes little sense, instead I think fs/stat.c should call
> upon arch-specific stat{,64} structure fillin routines that
> can do the magic, given a kstat struct.
> 
> Comments?

I'm not sure that it's worth doing for anything below the "widest" version
of stat.  For that one - yeah, no objections.
