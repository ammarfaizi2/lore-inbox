Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSDOVCo>; Mon, 15 Apr 2002 17:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313265AbSDOVCn>; Mon, 15 Apr 2002 17:02:43 -0400
Received: from mark.mielke.cc ([216.209.85.42]:27911 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S313264AbSDOVCn>;
	Mon, 15 Apr 2002 17:02:43 -0400
Date: Mon, 15 Apr 2002 16:57:40 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Bill Abt <babt@us.ibm.com>, drepper@redhat.com,
        linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futex Generalization Patch
Message-ID: <20020415165740.A28056@mark.mielke.cc>
In-Reply-To: <OF24E0B753.2B92A422-ON85256B9C.00512368@raleigh.ibm.com> <20020415172204.4B6073FE08@smtp.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 12:22:59PM -0400, Hubertus Franke wrote:
> typedef struct siginfo {
>    ...
>         union {
>                 int _pad[SI_PAD_SIZE];
>  
>                 struct {
>                         ...
>                 } _kill;
>  ...
> 
> I'd suggest we tag along the _sigfault semantics.
> We don't need to know who woke us up, just which <addr> got signalled.
> 

Is there issues with creating a new struct in the union that represents
exactly what you wish it to represent?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

