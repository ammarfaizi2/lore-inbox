Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVFMNA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVFMNA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVFMNA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:00:27 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:50886 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261549AbVFMNAM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:00:12 -0400
To: Rommer <rommer@active.by>
Cc: Bernd Petrovitsch <bernd@firmix.at>, linux-kernel@vger.kernel.org
Subject: Re: udp.c
References: <42AD74A3.1050006@active.by>
	<1118664180.898.13.camel@tara.firmix.at>
	<yw1xy89ebg14.fsf@ford.inprovide.com>
	<1118666058.898.23.camel@tara.firmix.at> <42AD81FC.9020404@active.by>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Mon, 13 Jun 2005 15:00:06 +0200
In-Reply-To: <42AD81FC.9020404@active.by> (rommer@active.by's message of
 "Mon, 13 Jun 2005 15:54:20 +0300")
Message-ID: <yw1xu0k2beeh.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rommer <rommer@active.by> writes:

> Bernd Petrovitsch wrote:
>> On Mon, 2005-06-13 at 14:24 +0200, Måns Rullgård wrote:
>>
>>>Bernd Petrovitsch <bernd@firmix.at> writes:
>>>
>>>
>>>>On Mon, 2005-06-13 at 14:57 +0300, Rommer wrote:
>>>>
>>>>>Where used strange function udp_v4_hash?
>>>>>linux-2.6.11.11, net/ipv4/udp.c:204
>>>>>
>>>>>static void udp_v4_hash(struct sock *sk)
>>>>
>>>>Since it is "static" the user must be in the same source file (or -
>>>>theoretically - any included header).
>>>
>>>It's not that simple.  It is assigned to the 'hash' field of a struct
>> If you interpret "called" word-by-word yes. I assumed "used".
>>
>>>proto, which is exported.  It could be used from anywhere, but
>> The the OP has to grep for dereferences for this hash variable and
>> check
>> if it is (or may be) from the given struct.
>> Well, that's the virtue of object-orientation: Follow the objects, not
>> the functions/methods.
>>
>>>hopefully isn't.  Something else is supposed to ensure that it is
>>>never called when using the UDP protocol.
>
> So, why BUG(), not just void function?

Calling the function would be the result of a bug elsewhere in the
code, which should be detected and reported.

-- 
Måns Rullgård
mru@inprovide.com
