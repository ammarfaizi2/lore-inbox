Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUJMOnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUJMOnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268674AbUJMOnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:43:25 -0400
Received: from us1.server44secre01.de ([80.190.243.163]:49345 "EHLO
	us1.server44secre01.de") by vger.kernel.org with ESMTP
	id S266561AbUJMOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:43:14 -0400
Date: Wed, 13 Oct 2004 16:42:06 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041013144206.GA4133@t-online.de>
References: <20041007165410.GA2306@t-online.de> <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org> <20041009092801.GC3482@bytesex> <20041009112839.GA2908@t-online.de> <20041009121845.GE3482@bytesex> <20041010085541.GA1642@t-online.de> <20041011151455.GC23632@bytesex> <20041011162153.GA9101@t-online.de> <1097665248.4421.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097665248.4421.9.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 12:00:48PM +0100, Alan Cox wrote:
> On Llu, 2004-10-11 at 17:21, Michael Geng wrote:
> > Thank you! Andrew, could you please forward the patch? 
> > Suggestion for a comment line:
> > Videotext: IOCTLs changed to match _IO macros in linux/ioctl.h
> 
> But have any of them changed ioctl number in the process and broken
> compatibility ?

No compatibility is broken, because old IOCTLs are remapped to new 
ones in the driver. The driver properly handles both old and new
IOCTLs after applying the patch. No user space programs have to be 
changed or recompiled. 

Michael
