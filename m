Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129295AbQKHAgl>; Tue, 7 Nov 2000 19:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129892AbQKHAgc>; Tue, 7 Nov 2000 19:36:32 -0500
Received: from shell.webmaster.com ([209.133.28.73]:20107 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S129295AbQKHAgU>; Tue, 7 Nov 2000 19:36:20 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Rogier Wolff" <R.E.Wolff@BitWizard.nl>,
        "Matti Aarnio" <matti.aarnio@zmailer.org>
Cc: "Lyle Coder" <x_coder@hotmail.com>, "RAJESH BALAN" <atmproj@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: malloc(1/0) ??
Date: Tue, 7 Nov 2000 16:36:19 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKEEGCLMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <200011080029.BAA06851@cave.bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This way all should work. However someone mentioned that the returns
> from "malloc" should be unique. Why would that be? That would prohibit
> my "1" trick. The statement implies you want to go about checking
> pointers for equality. If for example you have a memcmp (a, b) that
> has "if (a == b) return 0;" at the beginning. That would be allowed
> for the NIL pointers. (all malloc-0 results SHOULD compare equal
> anyway: there are 0 differences....)

	It's a SuSv2 thing:

"Upon successful completion with size not equal to 0, malloc() returns a
pointer to the allocated space. If size is 0, either a null pointer or a
unique pointer that can be successfully passed to free() will be returned.
Otherwise, it returns a null pointer and sets errno to indicate the error."

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
