Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTIINin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTIINin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:38:43 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:32919 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264108AbTIINil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:38:41 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
Date: Tue, 9 Sep 2003 15:39:49 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Schwab <schwab@suse.de>
References: <200309081715.09657@bilbo.math.uni-mannheim.de> <jellsztgf6.fsf@sykes.suse.de> <1063068835.28622.48.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063068835.28622.48.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309091539.49579@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. September 2003 02:53 schrieb Alan Cox:
> On Llu, 2003-09-08 at 17:04, Andreas Schwab wrote:
> > > Its not 100% reliable either 8).
> >
> > Could you please elaborate?  Casting -1 to an unsigned type is guaranteed
> > to yield the maximum value for that type, at least since C89, but I think
> > even K&R C did get it right.
>
> My error - its ~0 that is unreliable.

Uh-oh:

eike@bilbo:/mnt/kernel/linux-2.4.23-pre3> grep -r "~0[^xX]" *| wc -l
    713

Eike
