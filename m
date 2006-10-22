Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWJVT7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWJVT7A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJVT7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:59:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:3793 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751239AbWJVT67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:58:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=J3QxmFA+iFmybVEBo+dMXMucVQzcRIEv4kaLun3hiGBhLplTPf0FGSCUBC/dWrtLha/1urTqIQ/sn5qdzxpqS0h0tu7IGKwzdatGKhm9pAF4d0nv16ysslKuoGz5cnnmSTzS64f5Rbz6UdoytqKFB0Zw1OT02fLFe3qd6OEfh/E=
Message-ID: <86802c440610221258q29b19839i7290b628424f7dba@mail.gmail.com>
Date: Sun, 22 Oct 2006 12:58:57 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86-64: using cpu_online_map instead of APIC_ALL_CPUS
Cc: "Andi Kleen" <ak@muc.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <m1k62sz150.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_151546_29526991.1161547137510"
References: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com>
	 <m1k62sz150.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: 3064e46c78597782
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_151546_29526991.1161547137510
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Muli,

Can you test this one?

YH

On 10/22/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Yinghai Lu" <yinghai.lu@amd.com> writes:
>
> > Using cpu_online_map instead of APIC_ALL_CPUS for flat apic mode, So
> > __assign_irq_vector can refer correct per_cpu data.
> >
> > Cc: Muli Ben-Yehuda <muli@il.ibm.com>
> > Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>
>
> Nack.  This fixes the symptom not the bug.
> More comprehensive patches follow.
>
> Eric
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

------=_Part_151546_29526991.1161547137510
Content-Type: text/x-patch; name=io_apic.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etlv4lop
Content-Disposition: attachment; filename="io_apic.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCmluZGV4IGIwMDAwMTcuLjI5Y2FlOTIgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9pb19hcGljLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMu
YwpAQCAtNjM0LDcgKzYzNCw3IEBAIHN0YXRpYyBpbnQgX19hc3NpZ25faXJxX3ZlY3RvcihpbnQg
aXJxLCAKIAkJaW50IGZpcnN0LCBuZXdfY3B1OwogCQlpbnQgdmVjdG9yLCBvZmZzZXQ7CiAKLQkJ
ZG9tYWluID0gdmVjdG9yX2FsbG9jYXRpb25fZG9tYWluKGNwdSk7CisJCWNwdXNfYW5kKGRvbWFp
biwgdmVjdG9yX2FsbG9jYXRpb25fZG9tYWluKGNwdSksIG1hc2spOwogCQlmaXJzdCA9IGZpcnN0
X2NwdShkb21haW4pOwogCiAJCXZlY3RvciA9IHBvc1tmaXJzdF0udmVjdG9yOwo=
------=_Part_151546_29526991.1161547137510--
