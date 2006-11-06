Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423572AbWKFIPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423572AbWKFIPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423589AbWKFIPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:15:01 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:15787 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1423572AbWKFIPA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:15:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ANNOUNCE] kvm howto
Date: Mon, 6 Nov 2006 00:15:02 -0800
Message-ID: <64F9B87B6B770947A9F8391472E0321608EBF537@ehost011-8.exch011.intermedia.net>
In-Reply-To: <20061105171424.GA7045@irc.pl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] kvm howto
Thread-Index: AccA/h65tf/73vFJQCGoju6pVMapAwAfOENw
From: "Dor Laor" <dor.laor@qumranet.com>
To: "Tomasz Torcz" <zdzichu@irc.pl>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2006 08:15:00.0731 (UTC) FILETIME=[A791E4B0:01C7017B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BIOS check is a must, it checks bit #0 of MSR_IA32_FEATURE_CONTROL,
if it set this means that software cannot write to the MSR. If bit #2 is
clear too then when executing vmxon you'll get #GP.

So the check should better be there...

--
Dor Laor

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Tomasz Torcz
Sent: Sunday, November 05, 2006 7:14 PM
To: linux-kernel
Subject: Re: [ANNOUNCE] kvm howto

On Thu, Nov 02, 2006 at 03:25:41PM +0200, Avi Kivity wrote:
> I've just uploaded a HOWTO to http://kvm.sourceforge.net, including 
> (hopefuly) everything needed to get kvm running.  Please take a look
and 
> comment.

  I have some problems on Thinkpad z61t with Core Duo T2500.
/proc/cpuinfo shows "vmx" in flags, but module refuses to load:
[17462106.632000] kvm: disabled by bios

 I wandered around BIOS setup (latest version), but didn't found
anything about virtualization. Is BIOS check really necessary?

-- 
Tomasz Torcz                                                       72->|
80->|
zdzichu@irc.-nie.spam-.pl                                          72->|
80->|

