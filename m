Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSLASiz>; Sun, 1 Dec 2002 13:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSLASiz>; Sun, 1 Dec 2002 13:38:55 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:12520 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262322AbSLASiy>; Sun, 1 Dec 2002 13:38:54 -0500
Cc: Greg KH <greg@kroah.com>, <linux-security-module@wirex.com>,
       <linux-kernel@vger.kernel.org>
References: <Mutt.LNX.4.44.0212020441560.19785-100000@blackbird.intercode.com.au>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: James Morris <jmorris@intercode.com.au>
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Date: Sun, 01 Dec 2002 19:46:02 +0100
Message-ID: <873cph37dh.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@intercode.com.au> writes:

> On Sun, 1 Dec 2002, Greg KH wrote:
>
>> On Sun, Dec 01, 2002 at 05:59:10PM +0100, Olaf Dietsche wrote:
>> > >  	VERIFY_STRUCT(struct security_operations, ops, err);
>> > 
>> > This shouldn't be necessary anymore.
>> 
>> Good point, I'll remove it.  It was a hack anyway :)
>> 
>
> I think we still want to make sure that the module author has explicitly
> accounted for all of the hooks, in case new hooks are added.

VERIFY_STRUCT() now verifies, wether security_fixup_ops() has done its
job. So it does no harm, but it is useless, nevertheless.

If you want to check, wether a module has been recompiled, you should
add a length/sizeof(struct security_operations) parameter.

Regards, Olaf.
