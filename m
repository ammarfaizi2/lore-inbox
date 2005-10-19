Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbVJSWTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbVJSWTs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbVJSWTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:19:48 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:16838 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751595AbVJSWTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:19:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qlWbVmQWGLheEsfP2bIVoburpmc9sXP41sgjy6BHcmEv8txRYxfwJw9lywBe+pH+zzpgnmqqJ2AR9hLf3wBEJcrB3PAFB2DtEqw6pv6KjTjBHZzc5LMdTRs9r80kRm3Qi+gUzC8kY1kyOpYx/hysep/i6z7B7SXIEVlDYcoyBRg=
Message-ID: <4356C679.2090600@gmail.com>
Date: Thu, 20 Oct 2005 08:19:37 +1000
From: Grant Coady <gcoady@gmail.com>
Organization: http://bugsplatter.mine.nu/
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rolandd@cisco.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids: cleanup comments
References: <4eedl1h86sarh1i5g42o7vi21i7v1ece2m@4ax.com> <524q7di40y.fsf@cisco.com>
In-Reply-To: <524q7di40y.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> I don't think I like this.  I prefer the format
> 
> 	#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001 /* PCI-Cbus Bridge */
> 
> to taking two lines like
> 
> 	/* PCI-Cbus Bridge */
> 	#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001
> 
> If some script can't handle the first format then I think the script
> should be fixed.
> 
>  - R.
> 
Fair enough, glad I'm lazy, not done the whitespace cleanup :)

How's this one?

From: Grant Coady <gcoady@gmail.com>

pci_ids.h cleanup: convert // comment to /* comment */

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
  pci_ids.h |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc4-mm1a/include/linux/pci_ids.h	2005-10-17 15:14:41.000000000 +1000
+++ linux-2.6.14-rc4-mm1b/include/linux/pci_ids.h	2005-10-20 08:12:15.000000000 +1000
@@ -448,7 +448,7 @@
  #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
  #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252

-#define PCI_VENDOR_ID_COMPEX2		0x101a // pci.ids says "AT&T GIS (NCR)"
+#define PCI_VENDOR_ID_COMPEX2		0x101a /* pci.ids says "AT&T GIS (NCR)" */
  #define PCI_DEVICE_ID_COMPEX2_100VG	0x0005

  #define PCI_VENDOR_ID_WD		0x101c
@@ -1161,10 +1161,10 @@

  #define PCI_VENDOR_ID_INIT		0x1101

-#define PCI_VENDOR_ID_CREATIVE		0x1102 // duplicate: ECTIVA
+#define PCI_VENDOR_ID_CREATIVE		0x1102 /* duplicate: ECTIVA */
  #define PCI_DEVICE_ID_CREATIVE_EMU10K1	0x0002

-#define PCI_VENDOR_ID_ECTIVA		0x1102 // duplicate: CREATIVE
+#define PCI_VENDOR_ID_ECTIVA		0x1102 /* duplicate: CREATIVE */
  #define PCI_DEVICE_ID_ECTIVA_EV1938	0x8938

  #define PCI_VENDOR_ID_TTI		0x1103
@@ -1174,7 +1174,7 @@
  #define PCI_DEVICE_ID_TTI_HPT302	0x0006
  #define PCI_DEVICE_ID_TTI_HPT371	0x0007
  #define PCI_DEVICE_ID_TTI_HPT374	0x0008
-#define PCI_DEVICE_ID_TTI_HPT372N	0x0009	// apparently a 372N variant?
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009	/* apparently a 372N variant? */

  #define PCI_VENDOR_ID_VIA		0x1106
  #define PCI_DEVICE_ID_VIA_8763_0	0x0198

-- 
Thanks,
Grant.
