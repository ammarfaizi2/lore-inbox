Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272169AbRH3MFt>; Thu, 30 Aug 2001 08:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272170AbRH3MFk>; Thu, 30 Aug 2001 08:05:40 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:25605 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272169AbRH3MFa>; Thu, 30 Aug 2001 08:05:30 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.11218.125243.775849@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 16:04:34 +0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs: how to mount without journal replay?
In-Reply-To: <20010826130858.A39@toy.ucw.cz>
In-Reply-To: <20010826130858.A39@toy.ucw.cz>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > For recovering broken machine, I'd like to mount without replaying journal.

You cannot mount without replaying even in read-only mode, because
file-system meta-data are possibly inconsistent.

 > [reiserfs panics while replaying journal; seems there are still some bugs
 > hidden in there]. Unfortunately, "nolog" option does not seem imlemented.

There is a patch allowing to mount reiserfs if there was io error during
journal replay on mount. It is included into 2.4.9-ac* tree (it was sent
to Linus several times, but this did not avail).

Can you send to Reiserfs mail-list <Reiserfs-List@Namesys.COM> more
detailed information about your case, like ksymoopsed stack trace, etc.

 > Are there experimental to do that?
 > 								Pavel
 > PS: Please CC me.

Nikita.

 > -- 
 > Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
 > details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
 > 
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
