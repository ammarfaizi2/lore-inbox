Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbULTDWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbULTDWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 22:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbULTDWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 22:22:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4816 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261400AbULTDWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 22:22:05 -0500
Date: Sun, 19 Dec 2004 22:21:35 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Con Kolivas <kernel@kolivas.org>
cc: Mikhail Ramendik <mr@ramendik.ru>, Andrew Morton <akpm@digeo.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, lista4@comhem.se,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
In-Reply-To: <41C640DE.7050002@kolivas.org>
Message-ID: <Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com>
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
 <41C6073B.6030204@yahoo.com.au> <20041219155722.01b1bec0.akpm@digeo.com>
 <200412200303.35807.mr@ramendik.ru> <41C640DE.7050002@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Con Kolivas wrote:

> I still suspect the thrash token patch even with the swap token timeout 
> at 0. Is it completely disabled at 0 or does it still do something?

It makes it harder to page out pages from the task holding the
token.  I wonder if kswapd should try to steal the token away
from the task holding it, so in effect nobody holds the token
when the system isn't under a heavy swapping load.

-- 
He did not think of himself as a tourist; he was a traveler. The difference is
partly one of time, he would explain. Where as the tourist generally hurries
back home at the end of a few weeks or months, the traveler belonging no more
to one place than to the next, moves slowly, over periods of years, from one
part of the earth to another. Indeed, he would have found it difficult to tell,
among the many places he had lived, precisely where it was he had felt most at
home.  -- Paul Bowles
