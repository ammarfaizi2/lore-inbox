Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291658AbSBHQ6U>; Fri, 8 Feb 2002 11:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291649AbSBHQ6K>; Fri, 8 Feb 2002 11:58:10 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:44579 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291653AbSBHQ56>; Fri, 8 Feb 2002 11:57:58 -0500
Date: Fri, 8 Feb 2002 11:57:55 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
Message-ID: <20020208115755.E1429@devserv.devel.redhat.com>
In-Reply-To: <20020208110930.C1429@devserv.devel.redhat.com> <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet>; from tigran@veritas.com on Fri, Feb 08, 2002 at 04:59:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 04:59:47PM +0000, Tigran Aivazian wrote:
> On Fri, 8 Feb 2002, Arjan van de Ven wrote:
> > If you need even more in your code (I assume you do otherwise you wouldn't
> > have done the work) then I really suggest you take a long hard look and fix
> > the obvious bugs or the design....
> 
> Arjan, I completely agree with you, but please do not overlook one obvious
> thing -- sometimes (well, most of the time) in order to fix those stack
> corruption issues you _first_ need to apply this patch and then it becomes
> obvious that the reason for this "random" corruption is the stack
> overflow. A kernel panic is not shouting like "I am a stack overflow!"

Stack redzoning makes a lot of sense. And checking isn't that expensive...

