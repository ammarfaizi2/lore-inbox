Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbTFLBNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264671AbTFLBNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:13:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35576 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264666AbTFLBNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:13:21 -0400
Subject: Re: [patch] as-iosched divide by zero fix
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org, piggin@cyberone.com.au
In-Reply-To: <20030611182249.0f1168e4.akpm@digeo.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
	 <1055380257.662.8.camel@localhost> <20030611182249.0f1168e4.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055381318.662.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jun 2003 18:28:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 18:22, Andrew Morton wrote:

> hrm, OK.  Still not convinced about `batch'.

batch is only zero if {read,write}_batch_expire are zero. Nick, is that
legal/desirable? Or should we prevent that in the sysfs interface?

> -		if (write_time / batch > 2)
> +		if (write_time > batch * 2)
>
> -		if (batch / write_time > 2)
> +		if (batch > write_time * 2)

Much better! :)

	Robert Love

