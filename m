Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWJ2Xtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWJ2Xtn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWJ2Xtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:49:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:26392 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030456AbWJ2Xtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:49:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=igtAwCBBT3Ql3wmUcNK/DwHrl9HuNPqe3qL/Sl9J8eRStjlhDLvSN62/EHYoGcAvtboBGZPTzDrV6FfepjODErtOdtljlqA2PgfsZ4pIKO76GCoKikcx4dGHzgZE8MyQ712T+l6QvPniKvSwJH9rxhupITPnfAVhfRiUz7ixi2U=
Message-ID: <76366b180610291549p1d4aecf1p2e0480b3c841b66c@mail.gmail.com>
Date: Sun, 29 Oct 2006 18:49:41 -0500
From: "Andrew Paprocki" <andrew@ishiboo.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6 git kernel reporting bug in knodemgrd_0 during boot
Cc: "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <454538AA.9000104@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <76366b180610291341y7342a968ycd244753ce9bbbb7@mail.gmail.com>
	 <20061029223822.GH27968@stusta.de>
	 <4545349C.1070009@s5r6.in-berlin.de>
	 <454538AA.9000104@s5r6.in-berlin.de>
X-Google-Sender-Auth: 44841610585337d4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Andrew, what was the last kernel which didn't log this?

I was previously using a stock Debian snapshot from 2006-10-11 which
comes with the 2.6.17 kernel standard (vmlinuz-2.6.17-2-486 is what it
installs).
I had already rebuilt the 2.6.17 source that comes with that install,
tweaking the configuration for the VIA motherboard and it did not
report any problems. Last night I just git'd the latest 2.6 source and
copied the same .config from the previous kernel over, and answered
any new questions that popped up during make config for the newer
source.

> And did you change any of the IEEE1394 options in the kernel configuration?

I copied the .config from the working kernel over, and I don't believe
I changed anything from the working 2.6.17 configuration. These are
the options currently set:

# grep IEEE .config
# CONFIG_IEEE80211 is not set
# IEEE 1394 (FireWire) support
CONFIG_IEEE1394=y
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
# CONFIG_IEEE1394_EXPORT_FULL_API is not set
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
# CONFIG_IEEE1394_RAWIO is not set

-Andrew
