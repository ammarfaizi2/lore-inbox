Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284395AbRLDBpw>; Mon, 3 Dec 2001 20:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284606AbRLDANx>; Mon, 3 Dec 2001 19:13:53 -0500
Received: from ns.conwaycorp.net ([24.144.1.3]:44239 "HELO mail.conwaycorp.net")
	by vger.kernel.org with SMTP id <S284693AbRLCPhZ>;
	Mon, 3 Dec 2001 10:37:25 -0500
Date: Mon, 3 Dec 2001 09:37:19 -0600
From: Nathan Poznick <poznick@conwaycorp.net>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
Message-ID: <20011203153719.GA10261@conwaycorp.net>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net> <3C070FEC.3602CB49@pobox.com> <20011130114506.A4789@bee.lk> <15367.44557.930845.66428@abasin.nj.nec.com> <20011130163131.A12298@conwaycorp.net> <20011130161717.G504@mikef-linux.matchmail.com> <20011201131759.B11856@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201131759.B11856@castle.nmd.msu.ru>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Andrey Savochkin:

> Do you see "can't fill rx buffer" messages?
> If so, then your load is too big, and memory management is incapable of
> freeing memory in time.
> Right now the kernel doesn't allow to increase atomic allocation
> reservation (which is a serious misfeature), so you need to hack and
> change the reservation in the kernel.

Yes, I saw a combination of the "can't fill rx buffer" messages and
"card reports no resources" messages, and after a while it went to
just a whole bunch (few hundred) of the "card reports no resources"
messages, which continued to scroll across the console at the rate of
one every second or so until I took down networking and removed the
eepro100 module.

> If the network doesn't come alive when you remove the load, it's a second
> problem, a bug in the driver.  I've seen such reports, but they aren't
> frequent.  On my computer, the driver resumes operations well.
> Why the driver can't do it for some people needs deep investigations.

After I removed the load, I gave it about 10 minutes or so to see if
it would pick back up, but it didn't.

-- 
Nathan Poznick <poznick@conwaycorp.net>
PGP Key: http://drunkmonkey.org/pgpkey.txt

"I think everyone ought to come in and have a hot cup of cocoa and
come inside and be nice and snuggly."
-Crow (as Dr. Herly). #201
