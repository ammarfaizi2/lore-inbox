Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUEUUBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUEUUBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUEUUBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:01:51 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:13631 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S265973AbUEUUBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:01:31 -0400
Message-ID: <36233.165.165.44.119.1085169684.squirrel@165.165.44.119>
In-Reply-To: <40AE5DBB.6030003@infosciences.com>
References: <40AD3A88.2000002@infosciences.com>
    <20040521043032.GA31113@kroah.com>
    <40AE5DBB.6030003@infosciences.com>
Date: Fri, 21 May 2004 22:01:24 +0200 (SAST)
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
From: jkroon@cs.up.ac.za
To: "nardelli" <jnardelli@infosciences.com>
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
User-Agent: SquirrelMail/1.4.3-RC1
X-Mailer: SquirrelMail/1.4.3-RC1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-Scan-Signature: fcf4bd906bd36cf8da786bec2bf6438c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've made all of the changes that recommended below.  If it looks like
> I've missed anything, please indicate so.
>
>

[snip]

>>
>>>+	if (num_ports <= 0 || num_ports > 2) {
>>
>>
>> I like the idea of this check, but you are trying to test for a negative
>> value on a __u16 variable, which is always unsigned.  So that check will
>> never be true :)

What happens if num_ports == 0?  Not that hardware should ever report that.

[snip]

