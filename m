Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRDJXi7>; Tue, 10 Apr 2001 19:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDJXij>; Tue, 10 Apr 2001 19:38:39 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:27407 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S131832AbRDJXig>; Tue, 10 Apr 2001 19:38:36 -0400
Date: Wed, 11 Apr 2001 01:38:30 +0200
From: Kurt Roeckx <Q@ping.be>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010411013830.A9704@ping.be>
In-Reply-To: <20010405000215.A599@bug.ucw.cz> <9b04fo$9od$3@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <9b04fo$9od$3@ncc1701.cistron.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 11:20:24PM +0000, Miquel van Smoorenburg wrote:
> 
> the shutdown scripts
> include "kill -15 -1; sleep 2; kill -9 -1". The "-1" means
> "all processes except me". That means init will get hit with
> SIGTERM occasionally during shutdown, and that might cause
> weird things to happen.

-1 mean everything but init.

>From the manpage:

       If pid equals -1, then sig is sent to every process except
       for the first one, from  higher  numbers  in  the  process
       table to lower.

And later:

BUGS
       It  is impossible to send a signal to task number one, the
       init process, for which it has not installed a signal han-
       dler.   This  is  done to assure the system is not brought
       down accidentally.


Kurt

