Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129661AbQKIIjd>; Thu, 9 Nov 2000 03:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQKIIjX>; Thu, 9 Nov 2000 03:39:23 -0500
Received: from cassis.axialys.net ([195.115.102.11]:14091 "EHLO
	cassis.axialys.net") by vger.kernel.org with ESMTP
	id <S129661AbQKIIjE>; Thu, 9 Nov 2000 03:39:04 -0500
Date: Wed, 8 Nov 2000 21:21:02 +0100
From: Simon Huggins <huggie-lk@earth.li>
To: LKML <linux-kernel@vger.kernel.org>
Subject: PCMCIA versioning...
Message-ID: <20001108212102.B1032@paranoidfreak.freeserve.co.uk>
Mail-Followup-To: Simon Huggins <huggie-lk@earth.li>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com> <3A073C8D.B6511746@linux.com> <20001106154039.A19860@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001106154039.A19860@valinux.com>; from dhinds@valinux.com on Mon, Nov 06, 2000 at 03:40:39PM -0800
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
X-Attribution: huggie
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 03:40:39PM -0800, David Hinds wrote:
> [..]  I would need to know what kernel versions and what PCMCIA driver
> versions were involved. [..]

Is there actually a way to work out what version of userspace utilities
you are using?

I read Changes and it tells me that I need pcmcia-cs 3.1.21 (for
test10-final).  It also tells me I can find out the version using
cardmgr -V.
Yet whenever I build the pcmcia utils it grabs the version from
the kernel tree (include/pcmcia/version.h) and not from the file under
pcmcia-3.1.21 (in config.mk kernel is before local include dir).

Hence the bizarre result:
[huggie@langly /usr/src]$ pcmcia-cs-3.1.21/cardmgr/cardmgr -V
cardmgr version 3.1.22

(kernel's version.h is 3.1.22).

Um, is this normal, good, right and proper?
Does the version in Changes really mean "you should recompile
{cardmgr,cardctl} with each kernel"?

[ I'm using the kernel's pcmcia modules ]

-- 
----------(  "Have you seen a man who's lost his luggage?"   )----------
----------(                   -- Suitcase                    )----------
Simon ----(                                                  )---- Nomis
                             Htag.pl 0.0.17
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
