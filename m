Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbRAJWZZ>; Wed, 10 Jan 2001 17:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRAJWZP>; Wed, 10 Jan 2001 17:25:15 -0500
Received: from p3EE3CB90.dip.t-dialin.net ([62.227.203.144]:61713 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S130130AbRAJWZF>; Wed, 10 Jan 2001 17:25:05 -0500
Date: Wed, 10 Jan 2001 23:25:04 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010110232504.B9585@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <UTC200101082056.VAA147872.aeb@texel.cwi.nl> <20010108223445.V27646@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108223445.V27646@athlon.random>; from andrea@suse.de on Mon, Jan 08, 2001 at 22:34:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jan 2001, Andrea Arcangeli wrote:

> On Mon, Jan 08, 2001 at 09:56:18PM +0100, Andries.Brouwer@cwi.nl wrote:
> Hardlinks have nothing to do with `rmdir .`. See rmdir . as the equivalent
> pointed out by Alexander: "rmdir `pwd`".  `pwd` returns the same thing

You can't delete immutable directories such as . and .. Plus, don't ever
dare to think of interpreting rmdir arguments. Just do what is written.
rmdir . makes no sense. If someone wants rmdir `pwd` he's free to write
just that. Of course, it's ugly because getcwd and the like are kludges,
but you should only delete things you know anyhow.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
