Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbUJ1K4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbUJ1K4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbUJ1K4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:56:37 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:35243 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262894AbUJ1Kzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:55:50 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-9.tower-45.messagelabs.com!1098960948!6862937!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.9 page allocation failures
Date: Thu, 28 Oct 2004 06:55:47 -0400
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC3FE6@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9 page allocation failures
Thread-Index: AcS8z/KegU2xjgVbTqa6KBb86iOIugADLYDw
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Andrew Morton" <akpm@osdl.org>, "Badari Pulavarty" <pbadari@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ cat /proc/sys/vm/min_free_kbytes
886

What do you recommend it be set to?


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andrew Morton
Sent: Thursday, October 28, 2004 5:20 AM
To: Badari Pulavarty
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 page allocation failures

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi,
> 
> I see following page allocation failures while running IO intensive
> tests on 2.6.9. My tests didn't fail, so I guess its okay. But
> I never saw this before.
> 
> Its on a 4-way AMD64 machine with 7GB RAM. Tests create 10 4GB files
> on 10 disks (one filesystem per disk) in parallel. (dd if=/dev/zero
...)

Tried increasing /proc/sys/vm/min_free_kbytes?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
