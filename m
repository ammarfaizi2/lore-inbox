Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWEOCLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWEOCLO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 22:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWEOCLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 22:11:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53974 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751373AbWEOCLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 22:11:13 -0400
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
 userspace (Xorg) to enable devices without doing foul direct access
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	<20060429015116.2c3d964b.akpm@osdl.org>
	<1146301148.3125.7.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 14 May 2006 20:10:06 -0600
In-Reply-To: <1146301148.3125.7.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Sat, 29 Apr 2006 10:59:08 +0200")
Message-ID: <m1r72w6nsx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

>> > +	if (!pdev)
>> > +		return 1;
>> 
>> Can this happen?
>
> eh I suppose not; the other code doesn't check it either; fixed
>
>> 
>> > +	/* this can crash the machine when done on the "wrong" device */
>> > +	if (!capable(CAP_SYS_ADMIN))
>> > +		return 1;
>> 
>> Don't the file's permissions suffice?
>
> that's a more philosophical question; you can ask that question about
> the entire capability system ;) Other code in the same file uses this
> same capability for a same level of access though.


A minor nit.  This level of access should really be CAP_SYS_RAWIO.

Eric
