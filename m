Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbTIHQMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTIHQL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:11:56 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:33936 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262771AbTIHQLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:11:36 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
Date: Mon, 8 Sep 2003 18:12:36 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Schwab <schwab@suse.de>
References: <200309081715.09657@bilbo.math.uni-mannheim.de> <je3cf7uw0f.fsf@sykes.suse.de> <1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081812.36916@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 8. September 2003 17:58 schrieb Alan Cox:
> On Llu, 2003-09-08 at 16:42, Andreas Schwab wrote:
> > It's neither ugly, nor bogus.  The only 100% reliable way to assign the
> > maximum value to an unsigned integer is to use -1.
>
> Its not 100% reliable either 8). Properly you should use the limits.h
> values. The kernel assumes 2's complement so just adding a cast would
> probably keep gcc happy

gcc didn't even find that. He complained about a line slightly above this one. 
In limits.h there is no value equal to -1UL.

Eike
