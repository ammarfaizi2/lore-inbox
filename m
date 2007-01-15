Return-Path: <linux-kernel-owner+w=401wt.eu-S932083AbXAOW45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbXAOW45 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXAOW45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:56:57 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:57534 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932083AbXAOW44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:56:56 -0500
Message-ID: <45AC06B2.3060806@scientia.net>
Date: Mon, 15 Jan 2007 23:56:50 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel@vger.kernel.org, cw@f00f.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca>
In-Reply-To: <459C3F29.2@shaw.ca>
Content-Type: multipart/mixed;
 boundary="------------000807020807070906040407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807020807070906040407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi everybody.

Sorry again for my late reply...

Robert gave us the following interesting information some days ago:

Robert Hancock wrote:
> If this is related to some problem with using the GART IOMMU with memory 
> hole remapping enabled, then 2.6.20-rc kernels may avoid this problem on 
> nForce4 CK804/MCP04 chipsets as far as transfers to/from the SATA 
> controller are concerned as the sata_nv driver now supports 64-bit DMA 
> on these chipsets and so no longer requires the IOMMU.
>   


I've just tested it with my "normal" BIOS settings, that is memhole
mapping = hardware, IOMMU = enabled and 64MB and _without_ (!)
iommu=soft as kernel parameters.
I only had the time for a small test (that is 3 passes with each 10
complete sha512sums cyles over about 30GB data)... but sofar, no
corruption occured.

It is surely far to eraly to tell that our issue was solved by
2.6.20-rc-something.... but I ask all of you that had systems that
suffered from the corruption to make _intensive_ tests with the most
recent rc of 2.6.20 (I've used 2.6.20-rc5) and report your results.
I'll do a extensive test tomorrow.

And of course (!!): Test without using iommu=soft and with enabled
memhole mapping (in the BIOS). (It won't make any sense to look if the
new kernel solves our problem while still applying one of our two
workarounds).


Please also note that there might be two completely data corruption
problems. The onle "solved" by iommu=soft and another reported by Kurtis
D. Rader.
I've asked him to clarify this in a post. :-)



Ok,... now if this (the new kernel) would really solve the issue... we
should try to find out what exactly was changed in the code, and if it
sounds logical that this solved the problem or not.
The new kernel could just make the corruption even more rare.


Best wishes,
Chris.



--------------000807020807070906040407
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------000807020807070906040407--
