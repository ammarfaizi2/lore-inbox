Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTD2Wu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTD2Wu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:50:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261890AbTD2Wu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:50:57 -0400
Date: Wed, 30 Apr 2003 00:03:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Dave Peterson <dsp@llnl.gov>, linux-kernel@vger.kernel.org
Subject: Re: possible race condition in vfs code
Message-ID: <20030429230316.GR10374@parcelfarce.linux.theplanet.co.uk>
References: <200304150922.07003.dsp@llnl.gov> <3EAF01FE.2040600@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EAF01FE.2040600@kolumbus.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 01:51:42AM +0300, Mika Penttilä wrote:
> That piece of code looks wrong in other ways also..if we have unmounted 
> an active fs (which shouldn't be done but happens!) we shouldn't be at 
> least writing back to it anything! The !sb test isn't useful (we never 
> clear it in live inodes) and MS_ACTIVE handling is racy as hell wrt 
> umount...

Would you mind actually _reading_ kill_super() and stuff called by it?
