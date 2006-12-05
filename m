Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031283AbWLEURv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031283AbWLEURv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031294AbWLEURv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:17:51 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:49267 "EHLO mail.mnsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031272AbWLEURu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:17:50 -0500
Message-ID: <4575D3D2.20004@mnsu.edu>
Date: Tue, 05 Dec 2006 14:17:22 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
CC: Marty Leisner <linux@rochester.rr.com>, linux-kernel@vger.kernel.org,
       bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd
References: <200612052007.kB5K7ntk023359@laptop13.inf.utfsm.cl>
In-Reply-To: <200612052007.kB5K7ntk023359@laptop13.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can also use fakeroot(1).

Start fakeroot.
Change all of your permissions as you see fit.
make your cpio
exit fakeroot.



Horst H. von Brand wrote:
> Marty Leisner <linux@rochester.rr.com> wrote:
>   
>> I'm working on an embedded system with the 2.6 kernel -- cpio
>> initrd was a new feature I'm looking at (and very welcome).
>>
>> The major advantage I see is you don't have MAKE a filesystem
>> on the build host (doing cross development).  So you don't have
>> to be root.
>>     
>
>   
>> But its "useful" to change permissions/ownership of the initrd
>> files at times...
>>     
>
>   
>> Since a cpio is just a userspace created string of bits, I suppose
>> you can apply a set of ownership/permissions to files IN the archive
>> by playing with the bits...
>>     
>
> The easy way out is to unpack the initrd, fix permissions, and repack. That
> requires root, though (it creates devices).
>
>   
>> Does such a tool exist?  Comments?  Seems very useful in order to
>> avoid being root...
>>     
>
> I'd use sudo(1) + specially cooked commands to unpack/pack an initrd. It is
> a bit more work, but gives you extra flexibility (i.e., not just futzing
> around with permissions, can also add/replace/edit/rename/delete files, ...
> using bog standard tools).
>   
