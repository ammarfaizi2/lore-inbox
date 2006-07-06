Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWGFRrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWGFRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWGFRrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:47:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27049 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030367AbWGFRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:47:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
References: <20060703184836.GA46236@muc.de>
	<1151962114.16528.18.camel@localhost.localdomain>
	<20060704092358.GA13805@muc.de>
	<1152007787.28597.20.camel@localhost.localdomain>
	<20060704113441.GA26023@muc.de>
	<1152137302.6533.28.camel@localhost.localdomain>
	<20060705220425.GB83806@muc.de>
	<m1odw32rep.fsf@ebiederm.dsl.xmission.com>
	<20060706130153.GA66955@muc.de>
	<m18xn621i6.fsf@ebiederm.dsl.xmission.com>
	<20060706165159.GB66955@muc.de>
Date: Thu, 06 Jul 2006 11:46:00 -0600
In-Reply-To: <20060706165159.GB66955@muc.de> (Andi Kleen's message of "6 Jul
	2006 18:51:59 +0200, Thu, 6 Jul 2006 18:51:59 +0200")
Message-ID: <m18xn6zkx3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

>> With EDAC on my next boot I get positive confirmation that I either
>> pulled the DIMM that the error happened on, or I pulled a different
>> DIMM.
>
> How? You simulate a new error and let EDAC resolve it?

No. There is a status report that tells you which pieces of hardware
your memory controller sees.  It is just a simple list.

>> To the best of my knowledge mcelog even with the --dmi option cannot
>> give me that.
>
> You mean identify if a given DIMM is still plugged in? You can get that 
> information from dmidecode

If you can reliably decode an error to a DIMM that DMI reports, then
yes even if DMI gets the label wrong you can reboot and see if the label
you were aiming for is now missing.  The principle is the same.

The difference is that you can't reliably use DMI to decode to a DIMM.

If you look at memory controller registers you can reliably do the
same thing without relying on DMI.  It works every time.

Isn't something that just works, and is not at the mercy of the BIOS
developers with too little time worth doing?

Eric
