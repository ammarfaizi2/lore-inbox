Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUGLUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUGLUAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUGLUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:00:10 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:55544 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262080AbUGLUAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:00:01 -0400
Date: Mon, 12 Jul 2004 12:59:56 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040712195956.GA14105@taniwha.stupidest.org>
References: <20040710184357.GA5014@taniwha.stupidest.org> <E1BjPL3-00076U-00@calista.eckenfels.6bone.ka-ip.net> <20040711215446.GA21443@hh.idb.hist.no> <ccujbr$unl$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccujbr$unl$1@terminus.zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 05:56:11PM +0000, H. Peter Anvin wrote:

> No it won't, since if you're using file descriptors there *is* no C
> library buffer.  fclose() will, though, and then call close().

Data sits in the page-cache though, and if you loose power before
that's flushed you will loose data.  This is why fsync is needed to be
sure.


   --cw
