Return-Path: <linux-kernel-owner+w=401wt.eu-S1751750AbWLMXd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWLMXd2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWLMXd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:33:28 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:42816 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751750AbWLMXd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:33:27 -0500
Message-ID: <45808DC3.2010907@scientia.net>
Date: Thu, 14 Dec 2006 00:33:23 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: andersen@codepoet.org, Karsten Weiss <K.Weiss@science-computing.de>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org>
In-Reply-To: <20061213202925.GA3909@codepoet.org>
Content-Type: multipart/mixed;
 boundary="------------010600030205020008060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600030205020008060306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.

I've just looked for some kernel config options that might relate to our
issue:


1)
Old style AMD Opteron NUMA detection (CONFIG_K8_NUMA)
Enable K8 NUMA node topology detection.  You should say Y here if you
have a multi processor AMD K8 system. This uses an old method to read
the NUMA configuration directly from the builtin Northbridge of Opteron.
It is recommended to use X86_64_ACPI_NUMA instead, which also takes
priority if both are compiled in.

ACPI NUMA detection (CONFIG_X86_64_ACPI_NUMA)
Enable ACPI SRAT based node topology detection.

What should one select for the Opterons? And is it possible that this
has something to do with our datacorruption error?


2)
The same two questions for the memory model (Discontiguous or Sparse)



3)
The same two questions for CONFIG_MIGRATION ()


4)
And does someone know if the nforce/opteron iommu requires IBM Calgary
IOMMU support?



This is unrelated to our issue,.. but it would be nice if some of your
could send me their .config,.. I'd like to compare them with my own and
see if I could something tweak or so.
(Of course only people with 2x DualCore Systems ;) )



Chris.

--------------010600030205020008060306
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------010600030205020008060306--
