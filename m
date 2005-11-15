Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVKOCm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVKOCm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVKOCm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:42:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23743 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932290AbVKOCmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:42:55 -0500
Message-ID: <43794B23.7010303@redhat.com>
Date: Mon, 14 Nov 2005 20:42:43 -0600
From: Mike Christie <mchristi@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <4378650A.1070209@drzeus.cx> <1131964282.2821.11.camel@laptopd505.fenrus.org> <20051114111108.GR3699@suse.de> <1131967167.2821.14.camel@laptopd505.fenrus.org> <20051114112402.GT3699@suse.de> <1131967678.2821.21.camel@laptopd505.fenrus.org> <20051114113442.GU3699@suse.de> <1131969212.2821.27.camel@laptopd505.fenrus.org> <20051114120417.GA33935@dspnet.fr.eu.org> <43792C82.5010707@redhat.com> <20051115005800.GA9543@dspnet.fr.eu.org>
In-Reply-To: <20051115005800.GA9543@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Mon, Nov 14, 2005 at 06:32:02PM -0600, Mike Christie wrote:
> 
>>If you have stack problem with iscsi then you should post it to those 
>>lists or send me a pointer offlist. There were problems with iscsi and 
>>XFS but they should be fixed in mainline. The XFS + iscsi problems that 
>>have been reported have not been stack usage problems though.
> 
> 
> That hasn't been very efficient last time.  In any case, on the latest
> version I tried (0.4-408, I can't blow up the backup machine every
> other day):
> 
> - iscsi-tape is incompatible with tg3 and works with e1000
> 
> - iscsi-disk blows after a random time in what seems to be a (irq?)
>   stack explosion on x86 but not on x86-64 (which iirc has bigger
>   stacks).  Seems to because the serial console blows too and only
>   writes a handful of characters.
> 

And these only occur with 4k stacks? Do you have the traces still?
