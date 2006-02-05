Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWBEPLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWBEPLf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWBEPLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:11:35 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:496 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1750856AbWBEPLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:11:35 -0500
Message-ID: <43E6154C.80807@sw.ru>
Date: Sun, 05 Feb 2006 18:10:04 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <20060203201945.GA18224@kroah.com>
In-Reply-To: <20060203201945.GA18224@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 03, 2006 at 10:34:01AM -0800, Dave Hansen wrote:
>> Lastly, is this a place for krefs?  I don't see a real need for a
>> destructor yet, but the idea is fresh in my mind.
> 
> Well, what happens when you drop the last reference to this container?
> Right now, your patch doesn't cause anything to happen, and if that's
> acceptable, then fine, you don't need to use a struct kref.
> 
> But if not, then why have a reference count at all?  :)

Please note, this patch introduces only small parts of it.
It doesn't introduce the code which creates containers/destroys them etc.

As I mentioned in another email:
In OpenVZ we have 2-level refcounting (mentioned recently by Linus as in 
mm). Process counter is used to decide when container should 
collapse/cleanuped and real refcounter is used to free the structures 
which can be referenced from somewhere else.

Kirill

