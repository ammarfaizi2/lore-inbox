Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWHONr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWHONr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWHONr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:47:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:7538 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030292AbWHONr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:47:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Ek0Up+1uvXGUpCKu33WQRyOpFnUoeS0TljQZY6LGOzomdMWDpM/gSCdOBPfIopmB/QilUTuIUiyWVw+5l/YHCQkTrInGz2r+jXfyWmOzJiTD0qNT36vBDmwGMo13wyQRtZGnxi8SJoxpXl3g3t9O0GZgmeFy18e9b6GH095Eh6U=
Subject: Re: [PATCH][Fix] swsusp: Fix swap_type_of
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060815101611.GH7496@elf.ucw.cz>
References: <200608151218.41041.rjw@sisk.pl>
	 <20060815101611.GH7496@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 21:47:17 +0800
Message-Id: <1155649637.3448.4.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 12:16 +0200, Pavel Machek wrote:
> On Tue 2006-08-15 12:18:40, Rafael J. Wysocki wrote:
> > There is a bug in mm/swapfile.c#swap_type_of() that makes swsusp only be
> > able to use the first active swap partition as the resume device.
> > Fix it.
> 
> ACK. (And I guess this is 2.6.18 material, right? Or is that fix not
> needed in mainline?) 

This fixed an oops on suspend to disk.  Definitely 2.6.18 material.

Tony


