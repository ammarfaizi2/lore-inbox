Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWIGIwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWIGIwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWIGIwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:52:40 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:9560 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751131AbWIGIwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:52:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hEEXKdX20pPuYlOqyOqS2p0BKicGM4tjSG2K8cGV/P7Ohdsi+8iDvwfK9j0aktHSyOKx6cUmWeCxHLkXu8Vlxd7v00QUy0AZJQ49vFBx3H35ytXJu16xjkdn+Ad66h2eH8G5RSrtKToYFRle0Y0UtKe0eDVH1iZCY45TsamSoNs=
Message-ID: <b0943d9e0609070152v59c60eev3bbad18cd6d01dad@mail.gmail.com>
Date: Thu, 7 Sep 2006 09:52:38 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0609070140lb8dbee7pbedc0b38dc5a68b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
	 <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
	 <b0943d9e0609070104v1b747f79v3b10238954f389cd@mail.gmail.com>
	 <6bffcb0e0609070135i314f2740if067eeab342f29a2@mail.gmail.com>
	 <b0943d9e0609070137g5384b6dcp1ecff948661cd98@mail.gmail.com>
	 <6bffcb0e0609070140lb8dbee7pbedc0b38dc5a68b1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > CONFIG_DEBUG_MEMLEAK=y
> > > CONFIG_DEBUG_MEMLEAK_HASH_BITS=8

Have you tried 16? With 8, a negative argument is passed as order to
__get_free_pages(). I'll modify kmemleak to cope with this.

-- 
Catalin
