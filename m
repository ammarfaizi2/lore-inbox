Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319343AbSIKVWR>; Wed, 11 Sep 2002 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319344AbSIKVWR>; Wed, 11 Sep 2002 17:22:17 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:27311 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S319343AbSIKVWQ>; Wed, 11 Sep 2002 17:22:16 -0400
Date: Wed, 11 Sep 2002 22:26:14 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Oliver Neukum <oliver@neukum.name>, Roman Zippel <zippel@linux-m68k.org>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface
Message-ID: <20020911222614.A12614@kushida.apsleyroad.org>
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv> <E17pD2j-0007TM-00@starship> <200209112229.11975.oliver@neukum.name> <E17pEpj-0007Up-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17pEpj-0007Up-00@starship>; from phillips@arcor.de on Wed, Sep 11, 2002 at 11:15:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Really, that's not so, there are limits.  30 seconds?  Whatever.  
> Remember, during this time the service provided by the module is
> unavailable, so this is denial-of-service land.  You could of
> course put in extra code to abort the unload process on demand,
> but, hmm, it probably wouldn't work ;-)

If you're going to do it right, you should fix that denial-of-service by
waiting until the module has finished unloading and then demand-loading
the module again.

Ideally, those periodic "rmmod -a" calls should _never_ cause a
denial-of-service.

-- Jamie
