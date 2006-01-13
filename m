Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWAMS4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWAMS4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWAMS4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:56:32 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:8464 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1422822AbWAMS4a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:56:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43C7F35A.9010703@summitinstruments.com>
X-OriginalArrivalTime: 13 Jan 2006 18:56:28.0613 (UTC) FILETIME=[0F72DF50:01C61873]
Content-class: urn:content-classes:message
Subject: Re: no carrier when using forcedeth on MSI K8N Neo4-F
Date: Fri, 13 Jan 2006 13:56:27 -0500
Message-ID: <Pine.LNX.4.61.0601131345260.8379@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: no carrier when using forcedeth on MSI K8N Neo4-F
Thread-Index: AcYYcw98YsfgGkeGSkyGZEsmnNkQCA==
References: <43C7F35A.9010703@summitinstruments.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arne R. van der Heyde" <vanderHeydeAR@summitinstruments.com>
Cc: <linux-kernel@vger.kernel.org>, <c-d.hailfinger.kernel.2004@gmx.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2006, Arne R. van der Heyde wrote:

> I am trying to connect two identical MSI K8N Neo4-F servers with NVIDIA
> nForce4 gigabit Lan ports. When the two ports are connected together via
> a crossover cable, neither computer is able to detect a carrier on the
> Lan ports and are not able to communicate. When either of the nForce4
> gigabit port is connected to a Lan port on another computer with a
> different Lan hardware or to a port on a switch the forcedeth drivers
> detect a carrier and are able to communicate.
>

You need to use the correct kind of cross-over cable for the Gigabit
ports. Then, you need to set both ports manually because there
is no hardware (the switch) to handle the auto-configuration. The
default is usually `autoneg on`. This tells the switch to
auto-configure. Connected to another port, not a switch, this
means nothing and the device remains dormant.

You do this with `ethtool`. Set both to full-duplex and they should
work. Also, there is no "carrier". This is all multi-phase NRZ.

> It appears that the nForce4 Gigabit ports are not generating a carrier.
> Does the nForce4 not provide standard ethernet ports? If they are
> standard ethernet ports, how do I tell forcedeth to generate a carrier?
> Also how do I get forcedeth to run at a Gigabit?
>
> Thanks for any help,
>
> Best regards,
> Arne R. van der Heyde
> vanderHeydeAR@summitinstruments.com
>
> Summit Instruments Inc.
> 2236 N. Cleveland-Massillon Rd.
> Akron, Ohio 44333-1255  USA
>
> Phone (330)659-3312
> Fax   (330)659-3286
> www.summitinstruments.com
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
