Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280096AbRJaIBs>; Wed, 31 Oct 2001 03:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280101AbRJaIBj>; Wed, 31 Oct 2001 03:01:39 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:60945 "HELO due.stud.ntnu.no")
	by vger.kernel.org with SMTP id <S280096AbRJaIBc>;
	Wed, 31 Oct 2001 03:01:32 -0500
Date: Wed, 31 Oct 2001 09:01:25 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011031090125.B10751@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDCD06E.8AF8FF69@pobox.com>; from jjs@pobox.com on Sun, Oct 28, 2001 at 07:43:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan:
> We found that using the intel e100 driver
> instead of the eepro100 eliminates these
> errors - YMMV of course -

I've now tried the Intel driver, no help, still get the NFS timeouts (the
intel driver doesn't output anything to dmesg, so it's no way of telling if
the same things occur as in the eepro100 stock-kernel driver). 

This is how I do the test:

NFS share a filesystem
NFS mount it on another box (not running intel e100 nic)
Start bonnie++ on the box that has mounted the nfs share

After 10-20mins, the first NFS timeout comes (which means the card is out of
resources, and "halts" for a bit). When the card becomes out of resources,
it seems like it uses a few minutes before it comes online again, no wonder
why, tho.

Has anyone got any suggestions on how to start tracking down, and maybe
fixing this problem?  Or, is this a hardware error?  Or maybe a firmware
error?  Should I start contacting Dell and tell them that's there's a
possible error in their PowerEdge 2550-series?

-- 
Thomas
