Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbSIZTXE>; Thu, 26 Sep 2002 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbSIZTXE>; Thu, 26 Sep 2002 15:23:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1242 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261452AbSIZTXD>; Thu, 26 Sep 2002 15:23:03 -0400
Date: Thu, 26 Sep 2002 16:27:57 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Marco Colombo <marco@esi.it>
Cc: Ernst Herzberg <earny@net4u.de>, Adam Goldstein <Whitewlf@Whitewlf.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <Pine.LNX.4.44.0209262035060.26363-100000@Megathlon.ESI>
Message-ID: <Pine.LNX.4.44L.0209261627000.1837-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Marco Colombo wrote:
> On Thu, 26 Sep 2002, Ernst Herzberg wrote:
>
> > MaxClients 256  # absolute minimum, maybe you have to recompile apache
> > MinSpareServers 100  # better 150 to 200
> > MaxSpareServers 200 # bring it near MaxClients
>
> KeepAlive		On
> MaxKeepAliveRequests	1000

That sounds like an extraordinarily bad idea.  You really
don't want to have ALL your apache daemons tied up with
keepalive requests.

Personally I never have MaxKeepAliveRequests set to more
than 2/3 of MaxClients.

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

