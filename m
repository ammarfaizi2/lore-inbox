Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWIYIgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWIYIgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIYIgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:36:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3680 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWIYIgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:36:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gHw3DNo/KDFBiDHhf7DgnQNguQVy5MkWOWdBJqThGyYTtlSsDm7JlEkQS1ideAQsiuVJXAwrY3eyJJMVcVO/KfuakyjvSbZX1jj+YsYUKvjG21tpCI5/BfannW0QqJ+uADKY+FvJa+9kSFFzv1M494nf0j61DeEpL29KNs9mvHE=
Message-ID: <4517950D.8010907@gmail.com>
Date: Mon, 25 Sep 2006 10:36:06 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Henne <henne@nachtwindheim.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: droping a patch in mm
References: <451792E2.2020800@nachtwindheim.de>
In-Reply-To: <451792E2.2020800@nachtwindheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henne wrote:
> Hi!
> 
> Would you please drop:
> pci_module_init_conversion-in-scsi-subsys-2nd-try.patch
> cause it the moving of libata now it will only produce a lot of errors.
> I'll rewrite it today.

And this wrong too in that patch:
-	/* Translate error or zero return into zero or one */
-	return pci_module_init(&aic7xxx_pci_driver) ? 0 : 1;
+	return pci_register_driver(&aic7xxx_pci_driver);

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

