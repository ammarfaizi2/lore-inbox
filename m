Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753244AbWKFRNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbWKFRNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbWKFRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:13:36 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:20416 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1753244AbWKFRNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:13:36 -0500
Message-ID: <454F6D2C.30007@gmail.com>
Date: Mon, 06 Nov 2006 18:13:16 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Char: istallion, convert to pci probing
References: <17413142092390932669@wsc.cz> <200611031919.45391.eike-kernel@sf-tec.de> <454F207A.8080008@gmail.com>
In-Reply-To: <454F207A.8080008@gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Rolf Eike Beer wrote:
>> Jiri Slaby wrote:
>>> istallion, convert to pci probing
>>>
>>> Use probing for pci devices. Change some __inits to __devinits to use these
>>> functions in probe function. Create stli_cleanup_ports and move there
>>> cleanup code from module_exit() code to not have duplicite cleanup code.
>>>
>>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>>
>>> ---
>>> commit b90798585707a33d1835b752a18f1ca3b6a7da7b
>>> tree 7c99e2bcca81b25dc3ffdcf288b5a9c35433c098
>>> parent 7e8fb7980d776e6a7c0bd84cc48b1cb9de139b8f
>>> author Jiri Slaby <jirislaby@gmail.com> Sun, 29 Oct 2006 23:37:48 +0100
>>> committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 18:26:39 +0059
>>>
>>>  drivers/char/istallion.c |  116
>>> +++++++++++++++++++++++++++------------------- 1 files changed, 67
>>> insertions(+), 49 deletions(-)
>>>
>>> diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
>>> index f07716b..9e73d0d 100644
>>> --- a/drivers/char/istallion.c
>>> +++ b/drivers/char/istallion.c
>>> @@ -402,7 +402,6 @@ static int	stli_eisamempsize = ARRAY_SIZ
>>>  /*
>>>   *	Define the Stallion PCI vendor and device IDs.
>>>   */
>>> -#ifdef CONFIG_PCI
>>>  #ifndef	PCI_VENDOR_ID_STALLION
>>>  #define	PCI_VENDOR_ID_STALLION		0x124d
>>>  #endif
>> Remove that ifdef and define too. We _have_ the id in include/linux/pci_ids.h
> 
> Yup, you're right, I removed it in stallion, but not here, I'll post a patch.

Heh, hardly, it's in the patch no. 2 of this serie ;).

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
