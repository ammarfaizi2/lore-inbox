Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTDOV1N (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTDOV1M 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:27:12 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1290
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264097AbTDOV1K 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:27:10 -0400
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
From: Robert Love <rml@tech9.net>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Gert Vervoort <gert.vervoort@hccnet.nl>, tconnors@astro.swin.edu.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030415120000.A30422@beaverton.ibm.com>
References: <3E982AAC.3060606@hccnet.nl>
	 <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl>
	 <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl>
	 <20030415120000.A30422@beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050442676.3664.162.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 15 Apr 2003 17:37:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-15 at 15:00, Patrick Mansfield wrote:

> We never hold the host_lock while calling the detect function (unlike the
> io_request_lock, see the bizzare 2.4 code), so acquiring it inside
> ppa_detect is very wrong. I don't know why your scsi scan did not hang.

I do not have this device so I cannot test it, but your logic seems
correct.

This is a much nicer fix for the preempt-related issues than others
proposed, too.

Anyone out there who _can_ mount the device?  Can you test this?  It
ought to be merged if it works.  We need to get device drivers in 2.5 up
to par..

	Robert Love

