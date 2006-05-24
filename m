Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWEXQqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWEXQqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWEXQqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:46:42 -0400
Received: from spirit.analogic.com ([204.178.40.4]:37650 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932388AbWEXQql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:46:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 24 May 2006 16:46:39.0748 (UTC) FILETIME=[A109A440:01C67F51]
Content-class: urn:content-classes:message
Subject: Re: 4096 byte limit to /proc/PID/environ ?
Date: Wed, 24 May 2006 12:46:39 -0400
Message-ID: <Pine.LNX.4.61.0605241235110.2450@chaos.analogic.com>
In-Reply-To: <447481C0.5050709@moving-picture.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 4096 byte limit to /proc/PID/environ ?
Thread-Index: AcZ/UaErCW8a7++PQ3W9xK1krv3FxQ==
References: <447481C0.5050709@moving-picture.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "James Pearson" <james-p@moving-picture.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 May 2006, James Pearson wrote:

> It appears that /proc/PID/environ only returns the first 4096 bytes of a
> processes' environment.
>
> Is there any other way via userland to get the whole environment for a
> process?
>
> Thanks
>
> James Pearson


I think that /proc/PID/environ just returns the environment that
existed when the process was created, irrespective of size. You
can check this as:

#include <stdio.h>

main()
{
     setenv("FOO=", "1234", 1);
     printf("%d\n", getpid());
     pause();
}

Variable "FOO" will not appear in /proc. It you set the environment
in non-standard ways, overwriting the original, you can see it in
/proc.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
