Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSIZUUH>; Thu, 26 Sep 2002 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbSIZUUG>; Thu, 26 Sep 2002 16:20:06 -0400
Received: from [217.7.64.198] ([217.7.64.198]:62166 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id <S261476AbSIZUUG>;
	Thu, 26 Sep 2002 16:20:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Rik van Riel <riel@conectiva.com.br>, Marco Colombo <marco@esi.it>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Date: Thu, 26 Sep 2002 22:25:08 +0200
User-Agent: KMail/1.4.2
Cc: Adam Goldstein <Whitewlf@Whitewlf.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209261627000.1837-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0209261627000.1837-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209262225.08640.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


KeepAlive		On  # that is ok
MaxKeepAliveRequests	1000  # that is too high. No Client will request such count. Check your Pages: 
How many Images/Frames/etc you nee per request? Should not reach 100 ;-)
KeepAliveTimeout 15 # that is the key, but that is dangerous. Too high, and you will run out of MaxClients.
But you see that in serverstats ('K')

On Donnerstag, 26. September 2002 21:27, Rik van Riel wrote:
> On Thu, 26 Sep 2002, Marco Colombo wrote:
> > On Thu, 26 Sep 2002, Ernst Herzberg wrote:
> > > MaxClients 256  # absolute minimum, maybe you have to recompile apache
> > > MinSpareServers 100  # better 150 to 200
> > > MaxSpareServers 200 # bring it near MaxClients
> >
> > KeepAlive		On
> > MaxKeepAliveRequests	1000
>
> That sounds like an extraordinarily bad idea.  You really
> don't want to have ALL your apache daemons tied up with
> keepalive requests.
>
> Personally I never have MaxKeepAliveRequests set to more
> than 2/3 of MaxClients.
>


<Earny>

