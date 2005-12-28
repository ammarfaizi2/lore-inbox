Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVL1PQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVL1PQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVL1PQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:16:59 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52362 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S964843AbVL1PQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:16:58 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: 4k stacks
Date: Wed, 28 Dec 2005 17:16:42 +0200
User-Agent: KMail/1.8.2
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512241403.38482.vda@ilport.com.ua> <Pine.LNX.4.61.0512280808290.25369@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0512280808290.25369@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512281716.43089.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 December 2005 15:14, linux-os (Dick Johnson) wrote:
> >> Anyway, getting down to 20 bytes of stack-space available
> >> seems to be pretty scary.
> >
> > +       movl    %esp, %edi
> > +       movl    %edi, %ecx
> > +       andl    $~0x1000, %edi
> > +       subl    %edi, %ecx
> >
> > ecx will be equal to ?
> 
> Whatever the stack was minus that value ANDed with NOT 0x1000,
> i.e. 0x1000 minus the stack already in use. The code assumes
> that the stack starts and ends on a 0x1000 (page) boundary.
> If that's not true, then all bets are off.

Hmm. I must be thick today. (esp - (esp & 0xffffefff))
is always equal to (esp & 0x00001000). Which is either 0 or 0x1000.
--
vda
