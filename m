Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWFNRs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWFNRs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWFNRs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:48:27 -0400
Received: from web53612.mail.yahoo.com ([206.190.39.179]:35755 "HELO
	web53612.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932138AbWFNRs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:48:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=36ogpU9TPBP+0AfTTL3yx4sJNysLuQzFwNxcKoZ32THmJ7xW4TeEf4ZAOFqNueUlyAoxZ7HTLoWc+kMT05+0VFXPDPKuNauTy+x0BjScQRBP413RB9nKqy17SEzGyIHg/xjHJrnF5VMZcrQ8qG5WarNCFFC6NlKejcz0B7qkPSM=  ;
Message-ID: <20060614174825.94383.qmail@web53612.mail.yahoo.com>
Date: Wed, 14 Jun 2006 10:48:25 -0700 (PDT)
From: Jason <bofh1234567@yahoo.com>
Subject: Re: SO_REUSEPORT and multicasting
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1150296668.3490.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Linux follows the standards draft.  SO_REUSEPORT is
> a fairly obscure BSDism.

Standards are good.  I like standards.  I was not
aware that SO_REUSEPORT was that obscure.  My
programming instructor made it sound like every OS
supports it.  I guess he was wrong.  Is there a Linux
equivalent to SO_REUSEPORT?

> > Yes.  My code works great on HP-UX but does
> > nothing on Linux.  
> 
> That doesn't actually prove very much. Its very easy
> to write incorrect
> code that only works on one system, especially when
> endian-ness gets
> involved with network code.

I have written other unicast programs on Linux and
sftp'd them to HP-UX, compiled, and they ran great. 
The only change I have to make between Linux and HP-UX
is in the Makefile.  I have change the following line:
INCS= -I. -include /usr/include/errno.h #to use fedora

I comment out the -include on the HP-UX and everything
is great.

This multicast application was based on its TCP
brother.  The only difference is removing TCP and
installing multicast support.

> In particular if writing portable code you must
> remember to join the
> group. You must also remember that the various
> htons/htonl macros need
> to be correctly used or your code will break on
> little-endian systems.

All of those macros are used in the multicast.c file I
was given.

> The default IP_MULTICAST_LOOP value is probably also
> worth overriding if
> you are being fairly paranoid.
 
The wrapper I used has a function to set the TTL and
the loop values.  I set the TTL to 3 and the loop to
0.

Thanks,



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
