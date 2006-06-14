Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWFNSEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWFNSEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 14:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWFNSEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 14:04:50 -0400
Received: from web53605.mail.yahoo.com ([206.190.37.38]:30906 "HELO
	web53605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751253AbWFNSEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 14:04:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=S1KCot+8MXtAtfMB81NeJtLnkisyqXUDi4Z8Mpe252Cuh5ewAZwlRzWamIMqzKOesEgF3RpAeufXYydOJqzGprWXZfxhkuyW2N93I1QhCw7FIc8OkgAioJFZgF2bZU8zMO5QsCbv/sBTYWWSFhkZxwDiV5M/IDi84mfKagy846U=  ;
Message-ID: <20060614180448.13830.qmail@web53605.mail.yahoo.com>
Date: Wed, 14 Jun 2006 11:04:47 -0700 (PDT)
From: Jason <bofh1234567@yahoo.com>
Subject: Re: SO_REUSEPORT and multicasting
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44901FC2.7040600@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Courtier-Dutton <James@superbug.co.uk>
wrote:
> That address is a multicast address, and therefore
> needs to go in the 
> multicast routing table, and not the unicast one.
> You are using a command that only modifies the
> unicast table.
> 
> James

The broadcasts don't have to leave my PC so I
shouldn't need a multicast router, do I?  The client
is running in one terminal window and the server in a
second terminal window.

I checked the router man page and found the following:
route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0
This is an obscure one documented so people know how
to do it. This sets all of the class D (multicast) IP
routes to go via "eth0".  This is the correct normal
configuration line with a multicasting kernel.

If there is another command, will you please tell me
what it is?

Thanks,

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
