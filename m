Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWHCJHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWHCJHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWHCJHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:07:08 -0400
Received: from web25813.mail.ukl.yahoo.com ([217.146.176.246]:17009 "HELO
	web25813.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932404AbWHCJHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:07:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=ud4Iy/wGg/Si5QDXtkg25shQAoY4jZdyWKakBMna3tzlDyHZxpW6yR8GEp3x8YALb8OPc8czJI+F1VbCHhivyisc11vPOP0CPHlKC9ehLpiBkJoliIAQcauFLZWj75xgzKgc4f+QkwONU9Ed49r/Kp4Oe9PRlamoGbhI6WaTvP8=  ;
Message-ID: <20060803090706.99884.qmail@web25813.mail.ukl.yahoo.com>
Date: Thu, 3 Aug 2006 09:07:06 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : sparsemem usage
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Mapping out parts of a section is quite normal - think about the 640K to
> 1Mb hole in PC memory space.

OK. But I'm still worry. Please consider the following code

       for (...; ...; ...) {
                [...]
                if (pfn_valid(i))
                       num_physpages++;
                [...]
        }

In that case num_physpages won't store an accurate value. Still it will be
used by the kernel to make some statistic assumptions on other kernel
data structure sizes.

Francis
        



