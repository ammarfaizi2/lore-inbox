Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRAaHhJ>; Wed, 31 Jan 2001 02:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130336AbRAaHg6>; Wed, 31 Jan 2001 02:36:58 -0500
Received: from styx.suse.cz ([195.70.145.226]:10494 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130072AbRAaHgw>;
	Wed, 31 Jan 2001 02:36:52 -0500
Date: Wed, 31 Jan 2001 08:36:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Raufeisen <david@fortyoz.org>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010131083642.A964@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0101301716490.3105-100000@ns-01.hislinuxbox.com> <Pine.LNX.4.21.0101301755330.3205-200000@ns-01.hislinuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101301755330.3205-200000@ns-01.hislinuxbox.com>; from pgpkeys@hislinuxbox.com on Tue, Jan 30, 2001 at 06:04:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

1) You don't seem to have any drives on the VIA controller. If this is
true, I don't think this can be a VIA IDE driver problem.

2) In your original message you suggest bs=1024M, which isn't a very
good idea, even on a 768 MB system. Here with bs=1024k it seems to run
fine.

3) You sent next to none VIA related debugging info. lspci -v itself
isn't much valuable because I don't get the register contents. Also
hdparm -i of the drives attached to the VIA chip would be useful. Plus
also the contents of /proc/ide/via.

4) Did you check the problem you're experiencing isn't a memory problem?
That'd go away with removing some RAM.

Vojtech

PS. I'm not sure how wise is to use both ACPI and APM at once. Well, I
never used either in a server environment - I don't think it makes much
sense.

PPS. What should I do with a ksyms dump of the Advansys SCSI and a Tulip
NIC drivers? It isn't related anyhow.


-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
