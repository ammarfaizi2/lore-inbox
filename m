Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVDJTeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVDJTeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVDJTeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:34:04 -0400
Received: from hermes.domdv.de ([193.102.202.1]:48645 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261587AbVDJTeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:34:00 -0400
Message-ID: <42597FA7.2060407@domdv.de>
Date: Sun, 10 Apr 2005 21:33:59 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
References: <1113145420344@pavel_ucw.cz> <4259432F.4040206@domdv.de> <20050410181846.GB1349@elf.ucw.cz>
In-Reply-To: <20050410181846.GB1349@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>Hi! What about doing it right? Encrypt it with symmetric cypher
>>>and store key in suspend header. That way key is removed automagically
>>>while fixing signatures. No need to clear anythink.
>>
>>Good idea. I'll have a look though it will take a while (busy with my job).
>>
>>
>>>OTOH we may want to dm-crypt whole swap partition.
>>
>>This would leave the problem that the in-kernel data would be accessible
>>on the swap device after resume.
> 
> 
> I meant "when dm-crypt is used, encrypting swsusp data with second key
> is no longer _that_ nice"...

Hmm, thinking of a future swsusp2 with initrd capabilites encrption of
the suspend image itself is still useful to prevent data gathering after
resume. Using dm-crypt for encryption of the swap partition in this case
is useful during resume so this fits nicely together.

BTW: I spent my day on implementing the encryption of the suspend image
and will send patches after a few more tests.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
