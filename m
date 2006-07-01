Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWGALGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWGALGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWGALGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:06:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932512AbWGALGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:06:06 -0400
Date: Sat, 1 Jul 2006 04:05:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the
 kernel.
Message-Id: <20060701040558.fe8967b7.akpm@osdl.org>
In-Reply-To: <20060701105822.GA10714@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<44A3B8A0.4070601@aitel.hist.no>
	<20060629104117.e96df3da.akpm@osdl.org>
	<20060630215405.GA9744@aitel.hist.no>
	<20060630165532.5eadf286.akpm@osdl.org>
	<20060701105822.GA10714@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2006 12:58:22 +0200
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> On Fri, Jun 30, 2006 at 04:55:32PM -0700, Andrew Morton wrote:
> > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > 
> > Oh.  This is probably the generic_file_buffer_write() hang, due to
> > zero-length iovec segments.
> > 
> > If so, the below should fix it up.
> 
> I have not been able to reproduce the problem on mm4, so perhaps
> it went away.  Do you want me to test this patch on mm2 anyway?
> 

No, that'll be the cause, thanks.
