Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270544AbTGURaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270721AbTGUR1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:27:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3049 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S270667AbTGURZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:25:16 -0400
Subject: Re: [RFC][PATCH 2.6] PM Timer as primary timing source on i386
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: lkml <linux-kernel@vger.kernel.org>, arjanv@redhat.com
In-Reply-To: <20030719081407.GA2665@brodo.de>
References: <20030719081407.GA2665@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1058808917.19149.9.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Jul 2003 10:35:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-19 at 01:14, Dominik Brodowski wrote:
> This patch implements support for a different timing source for the i386
> architecture, the Power Management Timer (PMTMR). It offers correct results
> with a ~3.6MHz resolution even during aggressive Powermanagement like ACPI
> C-State transitions, throttling and/or frequency scaling. It is based partly 
> on Arjan's patch for 2.4.

Very cool! I had actually been working on a version of the same thing
bug got stalled on the duplicated ACPI parsing. I like your trick of
having it as a module to avoid the ACPI early boot parsing, but it could
cause problems with alternate time sources. Maybe later in the 2.6/2.7
time frame we can do some sort of delayed registering and time
selection. 

I'll play around with it and let you know if I have any other feedback.

Very nice work!
-john


