Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWJVQmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWJVQmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWJVQmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:42:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32851 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751163AbWJVQmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:42:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=MDoxqRVLlZe/2yZx8S89EP2sq8tBkH01BBCNhgwqPxMu8OT5UA3PNheBpPXmeO8K0V1zRZU0E8IFZDs9/rsnGF5ZXd8i8bLFNH6kznXzBjLDITnM54z/ZmUpYBhaW9BGtMeb7CU/HiGtLq9VmCqn9Ug79xa59hu2SG/b1pYbkfk=
Message-ID: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com>
Date: Sun, 22 Oct 2006 09:42:38 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@muc.de>,
       "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: [PATCH] x86-64: using cpu_online_map instead of APIC_ALL_CPUS
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_150162_12435174.1161535358427"
X-Google-Sender-Auth: 175bee80d3389469
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_150162_12435174.1161535358427
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using cpu_online_map instead of APIC_ALL_CPUS for flat apic mode, So
__assign_irq_vector can refer correct per_cpu data.

Cc: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

------=_Part_150162_12435174.1161535358427
Content-Type: text/x-patch; name=vector_allocation_domain.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etl6ftub
Content-Disposition: attachment; filename="vector_allocation_domain.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9nZW5hcGljX2ZsYXQuYyBiL2FyY2gveDg2
XzY0L2tlcm5lbC9nZW5hcGljX2ZsYXQuYwppbmRleCA3YzAxZGI4Li40OTBkZjY5IDEwMDY0NAot
LS0gYS9hcmNoL3g4Nl82NC9rZXJuZWwvZ2VuYXBpY19mbGF0LmMKKysrIGIvYXJjaC94ODZfNjQv
a2VybmVsL2dlbmFwaWNfZmxhdC5jCkBAIC0zMiw4ICszMiw3IEBAIHN0YXRpYyBjcHVtYXNrX3Qg
ZmxhdF92ZWN0b3JfYWxsb2NhdGlvbl8KIAkgKiBkZWxpdmVyIGludGVycnVwdHMgdG8gdGhlIHdy
b25nIGh5cGVydGhyZWFkIHdoZW4gb25seSBvbmUKIAkgKiBoeXBlcnRocmVhZCB3YXMgc3BlY2lm
aWVkIGluIHRoZSBpbnRlcnJ1cHQgZGVzaXRpbmF0aW9uLgogCSAqLwotCWNwdW1hc2tfdCBkb21h
aW4gPSB7IHsgWzBdID0gQVBJQ19BTExfQ1BVUywgfSB9OwotCXJldHVybiBkb21haW47CisJcmV0
dXJuIGNwdV9vbmxpbmVfbWFwOwogfQogCiAvKgo=
------=_Part_150162_12435174.1161535358427--
