Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBTVOV>; Tue, 20 Feb 2001 16:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130840AbRBTVOB>; Tue, 20 Feb 2001 16:14:01 -0500
Received: from p91b.xDSL-1mm.sentex.ca ([64.7.134.220]:64758 "EHLO
	littleboy.jernet.localnet") by vger.kernel.org with ESMTP
	id <S130835AbRBTVOA>; Tue, 20 Feb 2001 16:14:00 -0500
Message-ID: <3A92DCE0.BEE5E90E@sympatico.ca>
Date: Tue, 20 Feb 2001 16:08:48 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <01022020011905.18944@gimli> <96uijf$uer$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <01022020011905.18944@gimli>,
> Daniel Phillips  <phillips@innominate.de> wrote:
> >Earlier this month a runaway installation script decided to mail all its
> >problems to root.  After a couple of hours the script aborted, having
> >created 65535 entries in Postfix's maildrop directory.  Removing those
> >files took an awfully long time.  The problem is that Ext2 does each
> >directory access using a simple, linear search though the entire
> >directory file, resulting in n**2 behaviour to create/delete n files.
> >It's about time we fixed that.

In the case of your script I'm not sure this will help, but:
I've seen /home directories organised like /home/a/adamsonj,
/home/a/arthurtone, /home/b/barrettj, etc.
this way (crude) indexing only costs areas where it's needed,
without kernel modification. (app does it)  What other placed would we
need indexing *in* the filesystem?

