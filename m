Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289323AbSBEAua>; Mon, 4 Feb 2002 19:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289326AbSBEAuW>; Mon, 4 Feb 2002 19:50:22 -0500
Received: from zero.tech9.net ([209.61.188.187]:773 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289323AbSBEAuK>;
	Mon, 4 Feb 2002 19:50:10 -0500
Subject: Re: current->state after kmalloc
From: Robert Love <rml@tech9.net>
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <16Xthq-147i9wC@fwd04.sul.t-online.com>
In-Reply-To: <m16XtOG-000OVeC@amadeus.home.nl> 
	<16Xthq-147i9wC@fwd04.sul.t-online.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Feb 2002 19:50:10 -0500
Message-Id: <1012870211.1062.43.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-04 at 19:43, Oliver Neukum wrote:

> Is it safe with GFP_ATOMIC ?

You are guaranteed kmalloc will not sleep if you use GFP_ATOMIC, yes.

But I still find it gross to mark yourself sleeping but not sleep
immediately.

	Robert Love

