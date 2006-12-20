Return-Path: <linux-kernel-owner+w=401wt.eu-S964945AbWLTJLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWLTJLi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWLTJLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:11:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:5199 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964945AbWLTJLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:11:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=dLvSflbvvsny66Z63pTHm/WnkcwpR8adWX4oQfxSwMNlk7xxG2bxh7T3rEPayRRy82dFI6FNLg9RUUin1IsPF1LLvNGRoksbXmzLl3sPieDOJkW+KAC0gKy6QEk3heCE1OfmT6eUW6IzRtFEDW+a+kzCW1akiuUETjkSWJP1MVk=
Message-ID: <86802c440612200111j611445cdpb972e7cd6a0c5486@mail.gmail.com>
Date: Wed, 20 Dec 2006 01:11:35 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>, agalanin@mera.ru,
       take@libero.it
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Cc: "Andrew Morton" <akpm@osdl.org>, "Zhang Yanmin" <yanmin.zhang@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       bugme-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200612200145_MC3-1-D5AF-61E@compuserve.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25680_26755149.1166605895558"
References: <200612200145_MC3-1-D5AF-61E@compuserve.com>
X-Google-Sender-Auth: 9ad7c23892bd42d8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_25680_26755149.1166605895558
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> So an external interrupt occurred, the system tried to use interrupt
> descriptor #39 decimal (irq 7), but the descriptor was invalid.

but the irq is disabled at that time.

can you use attached diff to verify if the irq is enable somehow?

YH

------=_Part_25680_26755149.1166605895558
Content-Type: text/x-patch; name=test_init_isa_irqs.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evxiya9i
Content-Disposition: attachment; filename="test_init_isa_irqs.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pODI1OS5jIGIvYXJjaC94ODZfNjQva2Vy
bmVsL2k4MjU5LmMKaW5kZXggZDczYzc5ZS4uZmVkZGUzNCAxMDA2NDQKLS0tIGEvYXJjaC94ODZf
NjQva2VybmVsL2k4MjU5LmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2k4MjU5LmMKQEAgLTQy
MSw3ICs0MjEsMTEgQEAgdm9pZCBfX2luaXQgaW5pdF9JU0FfaXJxcyAodm9pZCkKIHsKIAlpbnQg
aTsKIAorCWlmICghaXJxc19kaXNhYmxlZCgpKQorCQlwcmludGsoImluaXRfSVNBX2lycXMoKTog
LTEgIGJ1ZzogaW50ZXJydXB0cyB3ZXJlIGVuYWJsZWQgZWFybHlcbiIpOwogCWluaXRfYnNwX0FQ
SUMoKTsKKwlpZiAoIWlycXNfZGlzYWJsZWQoKSkKKwkJcHJpbnRrKCJpbml0X0lTQV9pcnFzKCk6
IC0yICBidWc6IGludGVycnVwdHMgd2VyZSBlbmFibGVkIGVhcmx5XG4iKTsKIAlpbml0XzgyNTlB
KDApOwogCiAJZm9yIChpID0gMDsgaSA8IE5SX0lSUVM7IGkrKykgewo=
------=_Part_25680_26755149.1166605895558--
