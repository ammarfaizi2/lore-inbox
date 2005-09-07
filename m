Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVIGPMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVIGPMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVIGPMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:12:36 -0400
Received: from istanbul.uab.es ([158.109.168.138]:14768 "EHLO istanbul.uab.es")
	by vger.kernel.org with ESMTP id S932163AbVIGPMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:12:35 -0400
Date: Wed, 07 Sep 2005 17:12:54 +0200
From: =?ISO-8859-1?Q?M=E0rius_Mont=F3n?= <Marius.Monton@uab.es>
Subject: Re: 'virtual HW' into kernel (SystemC)
In-reply-to: <20050907141651.GA10075@kvack.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <431F0376.9020201@uab.es>
Organization: Cephis-UAB
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_dxhWT8jX0u2EBC3D5XoGaQ)"
X-Accept-Language: ca, es
X-Enigmail-Version: 0.92.0.0
References: <431EC16B.2040604@uab.es> <20050907141651.GA10075@kvack.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-OriginalArrivalTime: 07 Sep 2005 15:13:20.0301 (UTC)
 FILETIME=[AE8495D0:01C5B3BE]
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_dxhWT8jX0u2EBC3D5XoGaQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT



Benjamin LaHaise wrote:

>On Wed, Sep 07, 2005 at 12:31:07PM +0200, Màrius Montón wrote:
>  
>
>>At this point, we plan to develop a pci device driver to act as a bridge
>>between kernel PCI subsystem and SystemC simulator (in user space).
>>
>>Do you think this implementation is fine? Maybe it's better to register
>>a new bus
>>subsystem and link to a daemon to user space to run SystemC simulations?
>>We are open to any idea or suggestion about it.
>>    
>>
>
>That's actually quite a difficult approach to take as you aren't able to 
>fully simulate how the hardware interacts with the system, making concerns 
>like timing very difficult to accurately model. 
>
True, but our plan is to develop a module to wrap PCI comunication,
bypassing northbridge driver and PCI IP-core:

Application <-> our driver <-> kernel PCI-subsystem <-> our link <->
daemon <-> SystemC simulator.

Our link and our daemon get all PCI communication, and interface to
SystemC simulator.
Is that so complex to develop?

Also, we want to validate functional behavior, not timming. But we need
to validate entire funcionality, so we think an emulator won't be
accurate enough.

> A better approach is to 
>tie into a full system simulator -- qemu makes it very easy to add a new 
>pci device into the system.  This way your hardware simulator doesn't have 
>to worry about the complexities of kernel programming, and the resulting 
>device drivers doesn't need hooks for the simulator as it would see the 
>pci device as if it were installed in a system.
>
>  
>

>Btw, do you know of any inexpensive ways to be introduced SystemC 
>development on FPGAs?  Cheers,
>  
>
We are using Cynthesizer by ForteDS with a educational license. This
tool generates Verilog from SystemC. we are in troubles mapping this
verilog to FPGAs, due to libraries problems (a fix for that is using
ASIC libraries and then remap them to FPGA), but they said us new
version (3Q2005) will support FPGAs.


>		-ben
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

-- 
Màrius Montón i Macián   marius.monton@uab.es
<mailto:marius.monton@uab.es>  http://microelec.uab.es/~marius
<http://microelec.uab.es/%7Emarius>
Hardware Engineer
CEPHIS
Centre de Prototips i Solucions Hardware-Software
Dep. Microelectrònica i Sistemes Electrònics
ETSE - Universitat Autònoma de Barcelona (UAB) 	Phone: +34 935 813 534
Fax: +34 935 813 033
QC2088. ETSE. Campus UAB.
080193 Bellaterra


--Boundary_(ID_dxhWT8jX0u2EBC3D5XoGaQ)
Content-type: text/x-vcard; charset=utf-8; name=marius.monton.vcf
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=marius.monton.vcf

begin:vcard
fn;quoted-printable:M=C3=A0rius Mont=C3=B3n
n;quoted-printable;quoted-printable:Mont=C3=B3n;M=C3=A0rius
org;quoted-printable:UAB;Departament de Microelectr=C3=B2nica i Sistemes Electr=C3=B2nics
adr:Campus de la UAB;;QC-2088 ETSE;Bellaterra;Barcelona;08193;SPAIN
email;internet:marius.monton@uab.es
tel;work:+34935813534
x-mozilla-html:TRUE
url:http://cephis.uab.es
version:2.1
end:vcard


--Boundary_(ID_dxhWT8jX0u2EBC3D5XoGaQ)--
