Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261936AbSIYHqq>; Wed, 25 Sep 2002 03:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261937AbSIYHqq>; Wed, 25 Sep 2002 03:46:46 -0400
Received: from aba.krakow.pl ([62.233.163.30]:56500 "HELO two.aba.krakow.pl")
	by vger.kernel.org with SMTP id <S261936AbSIYHqp>;
	Wed, 25 Sep 2002 03:46:45 -0400
Date: Wed, 25 Sep 2002 09:51:59 +0200
From: =?iso-8859-2?Q?Pawe=B3?= Krawczyk <kravietz@aba.krakow.pl>
To: Simon Kirby <sim@netnation.com>
Cc: Adam Goldstein <Whitewlf@Whitewlf.net>, linux-kernel@vger.kernel.org
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Message-ID: <20020925075159.GD28695@aba.krakow.pl>
References: <20020925052411.GA8951@netnation.com> <E46487E7-D053-11D6-BCD3-000502C90EA3@Whitewlf.net> <20020925072026.GA9670@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020925072026.GA9670@netnation.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 12:20:26AM -0700, Simon Kirby wrote:

> Again, not locking, but fsync().  It's safe providing your machine never
> crashes. :)  Of course, there's still a chance it can be corrupted
> _with_ fsync() anyway, but the difference is the clients will get a
> result beore it guarantees the data will be on disk.

Many Linux distributions configure syslog to use synchronous writes
for each logged line, which caused very high load on busy systems
I've seen.

Go through your /etc/syslog.conf and change every "/var/log/messages"
to "-/var/log/messages", the minus enables asynchronous writes.

Also try disabling logging for Apache at all for some time (set ErrorLog,
AccessLog or CustomLog to /dev/null) and see what happens.

-- 
Pawe³ Krawczyk, Kraków, Poland  http://echelon.pl/kravietz/
horses: http://kabardians.com/
crypto: http://ipsec.pl/
