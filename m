Return-Path: <linux-kernel-owner+w=401wt.eu-S965143AbWLMULe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWLMULe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWLMULd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:11:33 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:41255 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965143AbWLMULc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:11:32 -0500
Message-ID: <45805E71.6060006@scientia.net>
Date: Wed, 13 Dec 2006 21:11:29 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Karsten Weiss <knweiss@gmx.de>
CC: linux-kernel@vger.kernel.org, ak@suse.de, andersen@codepoet.org,
       cw@f00f.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <4570CF26.8070800@scientia.net> <Pine.LNX.4.64.0612021048200.2981@addx.localnet> <45804C0B.4030109@scientia.net> <Pine.LNX.4.64.0612132014340.2963@addx.localnet>
In-Reply-To: <Pine.LNX.4.64.0612132014340.2963@addx.localnet>
Content-Type: multipart/mixed;
 boundary="------------030104070908080500030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030104070908080500030504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karsten Weiss wrote:

> Of course, the big question "Why does the hardware iommu *not*
> work on those machines?" still remains.
>   
I'm going to check AMDs errata docs these days,.. perhaps I find
something that relates. But I'd ask you to do the same as I  don't
consider myself as an expert in these issues ;-)

Chris Wedgwood said that iommu isn't used unter windows at all,.. so I
think the following three solutions would be possible:
- error in the Opteron (memory controller)
- error in the Nvidia chipsets
- error in the kernel


> I have also tried setting "memory hole mapping" to "disabled"
> instead of "hardware" on some of the machines and this *seems*
> to work stable, too. However, I did only test it on about a
> dozen machines because this bios setting costs us 1 GB memory
> (and iommu=soft does not).
>   
Yes... loosing so much memory is a big drawback,.. anyway it would be
great if you can make some more extensive tests that we'd be able to say
if memholemapping=disabled in the BIOS really solves that issue, too, or
not.

Does anyone know how memhole mapping in the BIOS relates to the iommu stuff?
Is it likely or explainable that both would sovle the issue?


> BTW: Maybe I should also mention that other machines types
> (e.g. the HP xw9300 dual opteron workstations) which also use a
> NVIDIA chipset and Opterons never had this problem as far as I
> know.
>   
Uhm,.. that's really strange,... I would have thought that this would
affect all systems that uses either the (mayby) buggy nforce chipset,..
or the (mayby) buggy Opteron.

Did those systems have exactly the same Nvidia-Type? Same question for
the CPU (perhaps the issue only occurs for a speciffic stepping)
Again I have:
nforce professional 2200
nforce professional 2050
Opteron model 275 (stepping E6)


btw: I think that is already clear but again:
Both "solutions" solve the problem for me:
Either
- memhole mapping=disabled in the BIOS (but you loose some memory)
- without any iommu= option for the kernel
or
- memhole mapping=hardware in the BIOS (I suppuse it will work with
software too)
- with iommu=soft for the kernel



Best wishes,
Chris.

--------------030104070908080500030504
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------030104070908080500030504--
