Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTJQWmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTJQWmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:42:10 -0400
Received: from ns.suse.de ([195.135.220.2]:10187 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261162AbTJQWmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:42:07 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F367D@scsmsx401.sc.intel.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm ZIPPY the PINHEAD and I'm totally committed to the festive mode.
Date: Sat, 18 Oct 2003 00:40:48 +0200
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F367D@scsmsx401.sc.intel.com> (Tony
 Luck's message of "Fri, 17 Oct 2003 15:19:49 -0700")
Message-ID: <jellrjfpxr.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

>> I expect there are probably different opinions about the idea
>> that "dd if=/dev/mem" exits without doing anything.  Sparc and
>> 68K have nearby code that bit-buckets writes and returns zeroes
>> for reads of page zero.  We could do that, too, but it seems like
>> kind of a hack, and holes on ia64 can be BIG (on the order of
>> 256GB for one box).
>
> Filling in the holes does seem like a bad idea, but so does returning
> EOF when you hit a hole (which is what I think your patch is doing).
>
> Would ENODEV be better?

EIO would probably fit better.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
