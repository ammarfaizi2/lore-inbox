Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSIBMdm>; Mon, 2 Sep 2002 08:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSIBMdm>; Mon, 2 Sep 2002 08:33:42 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:35028 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318283AbSIBMdk>;
	Mon, 2 Sep 2002 08:33:40 -0400
Date: Mon, 2 Sep 2002 14:38:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Rob Turk" <r.turk@chello.nl>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODE SENSE in sd.c; sddr09.c
Message-ID: <20020902123809.GA9286@win.tue.nl>
References: <UTC200209020041.g820fGS22828.aeb@smtp.cwi.nl> <akvg26$7nt$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akvg26$7nt$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 01:00:39PM +0200, Rob Turk wrote:

> > The patch below first separates out the MODE SENSE call,
> > and then tries it three times: on all pages (3F), only the first
> > four bytes; on the vendor page (0), only the first four bytes;
> > on all pages (3F), 255 bytes.
> 
> Would it be possible to move away from using 'standard' 255 bytes? Many SCSI
> device don't like requests for odd byte counts on 16-bit SCSI busses, and
> IDE isn't too crazy about it either. How about asking for 254 instead??

Well, as you can see I did move away from the 255. I ask for 4 bytes.
Only if that fails do I fall back on what we do today.

Andries
