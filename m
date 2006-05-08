Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWEHPP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWEHPP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWEHPP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:15:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:50581 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932370AbWEHPP4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:15:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EM98Uz3GmHKGcs+WOBU094vb/mLSKMHPHYojnq462qmA7732nuHJif+6pR/D9feqTY7FZDvOY40Uh2nLtyffMH7qFqw2L9MDGgvKi4vUSj9tPfnkNT+/RICfpOaPA5ipEB2/dDaMlR0q0K/5j0aPx11zg6T1W0tF8TWf6SyIohM=
Message-ID: <6bffcb0e0605080815t483955b3yf357175abb9a1a46@mail.gmail.com>
Date: Mon, 8 May 2006 17:15:53 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Madhukar Mythri" <madhukar.mythri@wipro.com>
Subject: Re: How to read BIOS information
Cc: "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <445F5DF1.3020606@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <445F5228.7060006@wipro.com>
	 <1147099994.2888.32.camel@laptopd505.fenrus.org>
	 <445F5DF1.3020606@wipro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/05/06, Madhukar Mythri <madhukar.mythri@wipro.com> wrote:
[snip]
> "proc/cpuinfo" says only HT support is their or not but, it will not say
> whether HT is Enalbled/Disabled..
> How to read ACPI tables ? Can  you give little info on this...
> even from Driver program, if its possible please tell me...
>

How about  comparing /sys/devices/system/cpu/cpu0/topology/core_id and
/sys/devices/system/cpu/cpu1/topology/core_id values?

On my northwood ht (single core) cpu0/topology/core_id and
cpu1/topology/core_id contain "0". For dual core system should be
something like

cpu0/topology/core_id = 0
cpu1/topology/core_id = 0
cpu2/topology/core_id = 1
cpu3/topology/core_id = 1

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
