Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSENV0s>; Tue, 14 May 2002 17:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316069AbSENV0r>; Tue, 14 May 2002 17:26:47 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:41734 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S316068AbSENV0r>;
	Tue, 14 May 2002 17:26:47 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: how to map "/dev/root" to "/proc/partitions" entry in user prog?
Date: Tue, 14 May 2002 21:26:47 +0000 (UTC)
Organization: Cistron
Message-ID: <abrven$gsu$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.44.0205141554240.2160-100000@spaz.localdomain>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1021411607 17310 195.64.65.67 (14 May 2002 21:26:47 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0205141554240.2160-100000@spaz.localdomain>,
Jeff Meininger  <jeffm@boxybutgood.com> wrote:
>How can I reliably map /dev/root to the corresponding entry in 
>/proc/partitions?

The first two lines in /proc/partitions are major/minor of the
device. Simply stat("/", &st) and use st.st_dev (and the major/minor
macros in glibc)

>Please Cc me in your response.

I'm reading and posting this on a mail2news gateway, sorry.

Mike.
-- 
"Insanity -- a perfectly rational adjustment to an insane world."
  - R.D. Lang

