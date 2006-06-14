Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWFNW5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWFNW5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWFNW5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:57:04 -0400
Received: from web53611.mail.yahoo.com ([206.190.39.178]:44735 "HELO
	web53611.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964981AbWFNW5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:57:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=doPhKBfEGT0BhRDDJlddJPU9WFVcFq8FW+iu4+OqyC5i0amKsF7DGpn82kcmjOFzDriKofd5x2dFz1q1JuX6YDm5YhI+1Ts7Kt8o/taLQhfbPG+7g63kAMwfURPLbCjS3t3+BMGg2ucIlFxtd+TTO4rGW2mKjXRe03z3Oy5MErg=  ;
Message-ID: <20060614225701.93656.qmail@web53611.mail.yahoo.com>
Date: Wed, 14 Jun 2006 15:57:01 -0700 (PDT)
From: Jason <bofh1234567@yahoo.com>
Subject: Re: SO_REUSEPORT and multicasting
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, jengelh@linux01.gwdg.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060614.151418.32173686.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Miller <davem@davemloft.net> wrote:
> Instead of degenerating this mailing list into a BSD
> socket
> programming class, you may find this informative:
> 
> 
>
http://www.unixguide.net/network/socketfaq/4.11.shtml
> 
> and it's covered extensively in W. Richard Steven's
> book, TCP/IP
> Illustrated, Volume 2.  It is considered the bible
> on BSD socket
> programming.
> 
> Particularly telling is the final paragraph from
> that web page which
> reads:
> 
> 	Basically SO_REUSEPORT is a BSD'ism that arose when
> 	multicast was added, evne though it was not used in
> the
> 	original Steve Deering code.  I believe some
> BSD-derived
> 	systems may also include it.  SO_REUSEPORT lets you
> bind
> 	the same address *and* port, but only if all the
> binders
> 	have specified it.  But when binding to multicast
> address
> 	(its main use), SO_REUSEADDR is considered
> identical to
> 	SO_REUSEPORT (p. 731, "TCP/IP Illustrated, Volume
> 2").
> 	So for portability of multicast applications, I
> always
> 	use SO_REUSEADDR.
> 
> I STRONGLY suggest you go read that reference to
> page 731 in
> the Steven book.


I agree that I don't want to start a flamewar or get
off topic.  However, I did state earlier that I did
switch to use SO_REUSEADDR and while the program
compiled on Linux (without error) the server did not
receive any packets.  Hence my questions regarding
Linux supporting multicasting.  

Thanks,

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
