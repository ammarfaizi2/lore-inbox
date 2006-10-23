Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWJWKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWJWKOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWJWKOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:14:45 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:52409 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751848AbWJWKOo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:14:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PAE and PSE ??
Date: Mon, 23 Oct 2006 12:13:46 +0200
User-Agent: KMail/1.9.1
Cc: Sandeep Kumar <sandeepksinha@gmail.com>, linux-kernel@vger.kernel.org
References: <37d33d830610212329o420e0ee4i75e6bddfcf2fb772@mail.gmail.com> <200610221215.26525.rjw@sisk.pl> <453C00B7.3040909@zytor.com>
In-Reply-To: <453C00B7.3040909@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610231213.47232.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 01:37, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Sunday, 22 October 2006 08:29, Sandeep Kumar wrote:
> >> Hi all,
> >> I have read in UTLK by bovet that the linux kernel does not uses the
> >> PSE bit on an x86
> >> machine. Then how come we have the hugetlbfs, which provides support
> >> for 4MB pages ?
> > 
> > AFAIK, PSE is only used when PAE is not set and then it enables the 4 MB
> > pages.  If PAE is set, the 4 MB pages are impossible because there are only
> > 512 entries per page table, but 2 MB pages can be used instead (and you don't
> > need to set PSE to use them).
> > 
> 
> You're wrong.
> 
> PSE refers to 4 MB pages when PAE is not used, and 2 MB pages when PAE 
> is used.
> 
> In theory, you could have PAE without PSE, which would only support 4K 
> pages.

Well, "AMD64 Architecture Programmer’s Manual" says the following:

The choice of 2 Mbyte or 4 Mbyte as the large physical-page size
depends on the value of CR4.PSE and CR4.PAE, as follows:
- If physical-address extensions are enabled (CR4.PAE=1), the
   large physical-page size is 2 Mbytes, regardless of the value
   of CR4.PSE.
- If physical-address extensions are disabled (CR4.PAE=0)
   and CR4.PSE=1, the large physical-page size is 4 Mbytes.
- If both CR4.PAE=0 and CR4.PSE=0, the only available page
   size is 4 Kbytes.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
