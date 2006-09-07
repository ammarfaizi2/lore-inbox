Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWIGIE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWIGIE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWIGIE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:04:57 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:62120 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750903AbWIGIE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:04:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ncKco3sssxcc7MQwZrkjHRnd/D8O8JgERaiAmmQIOVCYvEX8por9oq590j/tW7Tjc1gD/3wJE5qma+HW+LAull/3wnj4O2IVmbPoSDyHPe1onsGX1jfKjr9Jzl2h+NlNqiTjw7O1UL46P6hp25OAstQGtqiRIWG+9DIHC74to0I=
Message-ID: <b0943d9e0609070104v1b747f79v3b10238954f389cd@mail.gmail.com>
Date: Thu, 7 Sep 2006 09:04:56 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
	 <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> I get a kernel panic
> http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/panic.jpg
>
> http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/kml-config

Well, you set CONFIG_DEBUG_MEMLEAK_HASH_BITS to 32, this means that
kmemleak needs to allocate (sizeof(void*) * 2^32) which is 16GB of
RAM. I think a maximum of 20 should be enough (I got acceptable
results with 16 hash bits, the default value, and it seemed to do
better with 18).

-- 
Catalin
