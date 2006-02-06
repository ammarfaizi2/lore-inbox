Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWBFWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWBFWcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWBFWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:32:06 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:26931 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932406AbWBFWcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:32:04 -0500
Message-ID: <43E7CE55.80007@fr.ibm.com>
Date: Mon, 06 Feb 2006 23:31:49 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Hubertus Franke <frankeh@watson.ibm.com>, Greg KH <greg@kroah.com>,
       Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <20060203201945.GA18224@kroah.com> <43E3BE66.6050200@watson.ibm.com> <43E615BA.1080402@sw.ru>
In-Reply-To: <43E615BA.1080402@sw.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>> How do we want to create the container?
>> In our patch we did it through a /proc/container filesystem.
>> Which created the container object and then on fork/exec switched over.
> 
> this doesn't look good for a full virtualization solution, since proc
> should be virtualized as well :)

Well, /proc should be "virtualized" or "isolated", how do you expect a
container to work correctly ? plenty of user space tools depend on it.

C.
