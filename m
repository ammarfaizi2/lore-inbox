Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbULTPHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbULTPHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbULTPG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:06:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57767 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261517AbULTPGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:06:54 -0500
Date: Mon, 20 Dec 2004 10:06:36 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: mr@ramendik.ru
cc: Andrew Morton <akpm@osdl.org>, lista4@comhem.se,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       kernel@kolivas.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
In-Reply-To: <21322.195.133.60.161.1103533647.squirrel@195.133.60.161>
Message-ID: <Pine.LNX.4.61.0412201003360.13935@chimarrao.boston.redhat.com>
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1>   
 <20041219231250.457deb12.akpm@osdl.org> <21322.195.133.60.161.1103533647.squirrel@195.133.60.161>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 mr@ramendik.ru wrote:

> - Enjoy :) "eatmemory" will slowly eat up more and more RAM (visible in
> top as RSS); under 2.6.8.1 no screen freezes come, and under 2.6.9 and
> 2.6.10-rc3 they do come; under 2.6.10-rc3 I also see high CPU periods for
> kswapd.

The high cpu use for kswapd should be fixed by applying
the vm-pageout-throttling.patch patch from -mm.

I'll also come up with a patch to not have the swap token
used when the system is not under a swapin load...

-- 
He did not think of himself as a tourist; he was a traveler. The difference is
partly one of time, he would explain. Where as the tourist generally hurries
back home at the end of a few weeks or months, the traveler belonging no more
to one place than to the next, moves slowly, over periods of years, from one
part of the earth to another. Indeed, he would have found it difficult to tell,
among the many places he had lived, precisely where it was he had felt most at
home.  -- Paul Bowles
