Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312105AbSCQTUr>; Sun, 17 Mar 2002 14:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312104AbSCQTUi>; Sun, 17 Mar 2002 14:20:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312101AbSCQTU3>;
	Sun, 17 Mar 2002 14:20:29 -0500
Date: Sun, 17 Mar 2002 19:20:28 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020317192028.U4836@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <3C945D7D.8040703@mandrakesoft.com> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Sun, Mar 17, 2002 at 01:41:37PM +0000
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 01:41:37PM +0000, Anton Altaparmakov wrote:
> When you want large data streaming, i.e. you start getting worried about 
> memory pressure, then you want open(2) + O_DIRECT. No caching done. Perfect 
> for large data streams and we have that already. I agree that you may want 
> some form of asynchronous read ahead with passed pages being dropped from 
> the cache but that could be just a open(2) + O_SEQUENTIAL (doesn't exist yet).

	O_DIRECT isn't the right thing for large streaming.  You want
readahead and dropbehind.  O_DIRECT takes substantial penalties for its
lack of copy/cacheing.  This works fine in certain circumstances
(applications that keep their own caching), but for something like a
video or mp3, you'll win with working dropbehind easily.

Joel

-- 

Life's Little Instruction Book #444

	"Never underestimate the power of a kind word or deed."

			http://www.jlbec.org/
			jlbec@evilplan.org
