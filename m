Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422792AbWJPSfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422792AbWJPSfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbWJPSfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:35:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:51431 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422792AbWJPSfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:35:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k/RvMtzexdyo+hx0P7V9gpM6KuS72hhzPLCAuv196tDmkywQS2CTvUhs5SxSPqmBUGIGX9zXRfwZBg1HJeWQcdD6Hgy1dXpczfmrFPaLu0+hrYwp6EdnMNTh+h2H5YgR/KzIcz676I54Lf9rXb4YRNiUF14dC7OaN+5nMArtRAo=
Message-ID: <35a82d00610161135t3d65bf2ei46631e69bf6f7f12@mail.gmail.com>
Date: Mon, 16 Oct 2006 11:35:13 -0700
From: "Scott Baker" <smbaker@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: exported module symbols and warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm developing a pair of kernel modules. One module needs to export a
symbol that will be used by the second module. I'm doing this by using
EXPORT_SYMBOL(MySymbol) in the first module and declaring the symbol
as extern in the second module. It works fine.

However, there are a couple of warnings that I'm trying to clean up.
The first is when building the second module (the one that uses the
symbol). It is: "*** Warning: "MySymbol" [filename] undefined!"

The second warning occurs when insmod'ing the second module. It is:
"no version for "MySymbol" found: kernel tainted."

Can someone point me in the right direction? The modules are behaving
fine, but the warning messages are a bit unsightly.

I'm running RHEL4, kernel version 2.6.9-42.

Thanks,
Scott
