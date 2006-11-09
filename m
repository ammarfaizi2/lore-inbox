Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753787AbWKISoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbWKISoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbWKISoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:44:54 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:11241 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753491AbWKISox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:44:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=H+ELnh6AHmEJIL9mXNmr4Q2tx+K+genWMim92CPdXHwiIRSiXVORG1LYh71yhKjQDo8ZoaD6QpvPH9UmXlc0a4JSXINbvk80rzCAeztpGx+WSMgbKoo48qRU9hCO46FyrUS/Bqsbx7mo2BNQwXNZcLO8t8uyjlcMIEp9wpSLhYk=
Reply-To: andrew.j.wade@gmail.com
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Subject: Re: 2.6.19-rc4-mm2
Date: Thu, 9 Nov 2006 13:44:45 -0500
User-Agent: KMail/1.9.1
Cc: andrew.j.wade@gmail.com, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Kimball Murray" <kimball.murray@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A05C@EXNA.corp.stratus.com>
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A05C@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091344.47145.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Charlotte,

     I have just noticed that the garbled X-server mode is different
than what I thought it was. rinfo->depth is 24, but rinfo->bpp is 32.
(measured in radeon_write_mode). I haven't yet thought through the
implications of this. I've been unable to get the display correct, but
I've been trying to fix the wrong mode.
     The console mode is ->depth==8, ->bpp==8, and presumably the same
when it's garbled, but I've been unable to reproduce the problem since
instrumenting the kernel.

On Wednesday 08 November 2006 09:01, Richardson, Charlotte wrote:
> ... Do you think I should submit
> a patch that at least enables 24bpp for the chip I have where it
> definitely does work? I'm sure that is overly restrictive, but I don't
> know which ones work and which are broken at this point.

That sounds like a good idea to me, but I'm not very familiar with the
programming practices here.

...
> If you get a chance before I do, you might look at what Xfree86 does -
> they might have the workaround.

It looks like the X.org radeon driver doesn't support 24bpp.

-ajw
