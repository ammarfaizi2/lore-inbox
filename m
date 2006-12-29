Return-Path: <linux-kernel-owner+w=401wt.eu-S1753720AbWL2Isj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbWL2Isj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 03:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWL2Isj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 03:48:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:18681 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbWL2Isj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 03:48:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PEGuCGhbW9ykChODdRm/9qf+ePKeJOKQ8xiyUI2xLIDgJYdIy+7OJcvW8Nim275KbdrR9rNIWlP9R9ZzGR0adXWuttl4zs/Sq1NRMIiDTfnMe4IbMkTRAXaNuzfjgZEK8VpFF9PZe82HQx9koupAGlyr+qppP0EoI1Ujg/ctEJQ=
Message-ID: <b6a2187b0612290048o6001f992p4a4741cf622f0068@mail.gmail.com>
Date: Fri, 29 Dec 2006 16:48:37 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: open /dev/kvm: No such file or directory
Cc: "Avi Kivity" <avi@argo.co.il>, "Dor Laor" <dor.laor@qumranet.com>,
       lkml <linux-kernel@vger.kernel.org>, "Greg KH" <greg@kroah.com>
In-Reply-To: <200612290650.28508.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>
	 <b6a2187b0612280742x1b613849ye23aca38c71a5871@mail.gmail.com>
	 <4593E7EB.7070801@argo.co.il> <200612290650.28508.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 December 2006 16:51, Avi Kivity wrote:
> > Greg, /dev/kvm is a MISC_DYNAMIC_MINOR device. Is there any way of
> > using it without udev? Should I allocate a static number?
>
> You can write a small script that parses /proc/misc and creates the device,
> like
>
> # /sbin/mknod /dev/kvm c 10 `grep '\<kvm\>' /proc/misc | cut -f 1 -d\ `
>
> If you already have an init script, e.g. to set up tun/tap devices,
> it would make sense to put it in there.
>
>         Arnd <><
>

That works. That's exacting what I'm looking for.

Thank you,
Jeff.
