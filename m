Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSH1Lta>; Wed, 28 Aug 2002 07:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318793AbSH1Lsi>; Wed, 28 Aug 2002 07:48:38 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:35036 "EHLO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with ESMTP
	id <S318794AbSH1Lrr>; Wed, 28 Aug 2002 07:47:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
References: <20020826133028.GA21965@cissol7.cis.nctu.edu.tw>
	<1030369551.1750.4.camel@irongate.swansea.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Wed, 28 Aug 2002 13:51:58 +0200
In-Reply-To: <1030369551.1750.4.camel@irongate.swansea.linux.org.uk> (Alan
 Cox's message of "26 Aug 2002 14:45:51 +0100")
Message-ID: <871y8jxktd.fsf@Login.CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> But, the credentials are per-task in Linux, so it's possible to have
>> two tasks in a process running under different UIDs.
>
> Really useful isnt it

And not supported by GNU libc, neither officially nor by the current
implementation. :-(

I'd really like to have an explicit parameter for all these process
attributes (the credentials, chroot, maybe something else I'm missing
here; some kind of handle is probably required).  chroot() on open()
wouldn't have to require privileges, so it could help web servers
quite a bit.

Some day, I'm going to implement something like this in userspace
(using a privileged daemon and file descriptor passing).  But
performance will be horrible.

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          fax +49-711-685-5898
