Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbULUBqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbULUBqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 20:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbULUBqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 20:46:30 -0500
Received: from webmail.sub.ru ([213.247.139.22]:25103 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261720AbULUBq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 20:46:28 -0500
From: Mikhail Ramendik <mr@ramendik.ru>
To: lista4@comhem.se
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Tue, 21 Dec 2004 04:46:15 +0300
User-Agent: KMail/1.7.1
Cc: kernel@kolivas.org, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com
References: <1348970.1103547593171.JavaMail.tomcat@pne-ps1-sn1>
In-Reply-To: <1348970.1103547593171.JavaMail.tomcat@pne-ps1-sn1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412210446.16141.mr@ramendik.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:

> >This patch should have the desired effect.
>
> Yes, it sure has. And with that I mean, YES. My testcase shows no freezes
> now, and it has the same swapping time as 2.6.8.1-bk2.

Confirmed.

On 2.6.10-rc3 with Con's patch, when I run the memory eater, there is a high 
kswapd CPU load for about 10 seconds, then things are OK. The screen never 
freezes at that time or at any other moment.

When I add vm-pageout-throttling.patch from -mm, the CPU load in the beginning 
is somewhat less constant but remains there.

While it would be nice to fix the high CPU load, the system is usable as it 
is.

-- 
Yours, Mikhail Ramendik

