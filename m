Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291466AbSBMJen>; Wed, 13 Feb 2002 04:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291463AbSBMJef>; Wed, 13 Feb 2002 04:34:35 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:23304 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S291470AbSBMJeV>; Wed, 13 Feb 2002 04:34:21 -0500
Message-ID: <3C6A32ED.755159F3@aitel.hist.no>
Date: Wed, 13 Feb 2002 10:33:33 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.4-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net> <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu> <20020212165504.A5915@devcon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:

> I don't know if any filesystem currently relocates blocks if you
> overwrite a file, but it's certainly possible and allowed (everything
> else except the filesystem itself simply must not care where the data
> actually ends up on the disk).
> 
A log-structured fs will write new blocks everytime, afaik.
Ext3 with data journalling keeps copies of recently written data
in the journal.  Now, if you create a "secret" file and then overwrite
it you'll still find a copy in the journal until the journal wraps
It may not wrap if the next thing you do is umount/shutdown.

A secure rm must know the fs it works with.  A better solution
is to overwrite the entire partition with garbage. The only
perfect way is to destroy the magnetic surfaces though.


Helge Hafting
