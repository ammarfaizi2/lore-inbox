Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSD0LK2>; Sat, 27 Apr 2002 07:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313138AbSD0LK1>; Sat, 27 Apr 2002 07:10:27 -0400
Received: from ns.suse.de ([213.95.15.193]:31499 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313125AbSD0LK0>;
	Sat, 27 Apr 2002 07:10:26 -0400
Date: Sat, 27 Apr 2002 13:10:25 +0200
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.5.x-dj and SCSI error handling.
Message-ID: <20020427131025.F14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, I just woke up to about a dozen reports of the same 'bug'
all with patches which are so wrong they stand no chance of application
by me or Linus, posting here is quicker than me pointing those people
(and those who may follow them) to the answer.

The recent patch from Christoph Hellwig which kills off
the last remaining remnants of the old style SCSI error handling.
The reason these drivers no longer compile due to missing 'abort' and
'reset' functions is due to the fact that they need converting to
new-style error handling.

For instructions on how to do this, read http://www.andante.org/scsi_eh.html

For instructions on how not to this..
o   Do not send me patches that just remove the reset: and abort:
    functions. This gives us no error handling whatsoever.
o   Do not send me patches re-adding the 'missing' reset & abort functions
    to the Scsi_Host_Template struct.  This gets us nowhere.
o   Yes, I know ide-scsi, and various other scsi drivers are broken.
    Fix them, or be patient and wait for them to be fixed.


    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
