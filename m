Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWAZITq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWAZITq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWAZITq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:19:46 -0500
Received: from mail.gmx.net ([213.165.64.21]:62442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751037AbWAZITp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:19:45 -0500
X-Authenticated: #428038
Date: Thu, 26 Jan 2006 09:19:40 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126081940.GA13125@merlin.emma.line.org>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2006, Albert Cahalan wrote:

> It's misleading to say that MacOS doesn't allow a file
> descriptor. MacOS has something similar to what Linux
> has, but not in the normal filesystem namespace. You
> specify a name to get a handle. Of course, on MacOS,
> Joerg also uses -scanbus to create nonsense.

OK, so Jörg created this "nonsense", i. e. a triple of stupid numbers,
and claims he's using them to provide device lists to applications.

What prevents any of these GUIs from treating the "name" as an opaque
string? How would ATA:4,0,0 be different from 2,2,0 or /dev/hdc?

And how is the phantom GUI application obtaining the data? It needs to
scan all buses anyhow, and run -scanbus for each and every "transport
identifier" to get a grip of all devices, because cdrecord-with-libscg
is too stupid to do that by itself and unlist inferior (in its view, or
in the public view) identifiers (such as the PIO-only ATAPI:).

Here's an idea:

recognizing cdrecord may be portable, I wonder if it (or libscg for that
matter) is extensible or made decisions where it can decouple its
devices from the GUI application. Stating that the device ID no matter
how it looks today would be an opaque string not to be processed by the
GUI might be a first step to gain the necessary degrees of freedom to
change to ATA:/dev/hdc or just /dev/hdc (I don't mind which).

> Using numbers for CD burners is like trying to send email
> to the IP address of the recipient, which half-way worked
> until DHCP was invented. Wait, we could have all email
> clients offer a -scannet option. :-)

Well, in PeeCees, the BIOS presents that list of primary/secondary
master/slave, so there's /some/ point in it. Once hotplug comes into
play, it's all vain though.

(removing Lee from the Cc: list)

-- 
Matthias Andree
