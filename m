Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUCHPK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUCHPK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:10:26 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:8142 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262502AbUCHPKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:10:25 -0500
Message-ID: <404C8CBB.1030008@nortelnetworks.com>
Date: Mon, 08 Mar 2004 10:09:47 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: Andy Isaacson <adi@hexapodia.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
References: <20040307144921.GA189@elf.ucw.cz>	 <20040307164052.0c8a212b.akpm@osdl.org>	 <20040308063639.GA20793@hexapodia.org> <1078738772.4678.5.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Note that there are some applications for which it is a *bug* if an
>>mlocked page gets written out to magnetic media.  (gpg, for example.)
>>
> 
> mlock() does not guarantee things not hitting magnetic media, just as
> mlock() doesn't guarantee that the physical address of a page doesn't
> change.

The mlock() man page sure seems to hint that they do, by explicitly 
describing its use by high-security data processing as a way to keep the 
information from getting to disk.  There also seem to be a lot of 
references on the web about using mlock() in secure programming.

Something is not right...

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

