Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWDAVdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWDAVdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 16:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWDAVdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 16:33:22 -0500
Received: from smtp1.xs4all.be ([195.144.64.135]:52436 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932293AbWDAVdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 16:33:22 -0500
Date: Sat, 1 Apr 2006 23:32:55 +0200
From: Frank Gevaerts <frank@gevaerts.be>
To: Jean Delvare <khali@linux-fr.org>
Cc: Frank Gevaerts <frank@gevaerts.be>, Robert Love <rlove@rlove.org>,
       linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-ID: <20060401213255.GA30380@gevaerts.be>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Frank Gevaerts <frank@gevaerts.be>, Robert Love <rlove@rlove.org>,
	linux-kernel@vger.kernel.org
References: <20060314205758.GA9229@gevaerts.be> <20060328182933.4184db3f.khali@linux-fr.org> <20060328170045.GA10334@gevaerts.be> <20060401170422.cc2ff8c2.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401170422.cc2ff8c2.khali@linux-fr.org>
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
User-Agent: Mutt/1.5.9i
X-gevaerts-MailScanner: Found to be clean
X-MailScanner-From: fg@gevaerts.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 05:04:22PM +0200, Jean Delvare wrote:
> Hi Frank,
> 
> > > I have some doubt about this. The Thinkpad R52 is already supported
> > > (with identifier string "ThinkPad R52", unsuprisingly) and "ThinkPad H"
> > > doesn't exactly sound sane. Looks like your DMI data is corrupted or
> > > something. Could you please provide the output of dmidecode and
> > > vpddecode on your laptop?
> > 
> > They are attached.
> 
> > # dmidecode 2.8
> > (...)
> > System Information
> > 	Manufacturer: IBM
> > 	Product Name: 1846AQG
> > 	Version: ThinkPad H   
> 
> OK, so as strange as it sounds, that's really the string as stored in
> the DMI table.

Yes. That's where I looked when I made the patch.

> How odd... You have to understand that I'm a bit
> reluctant to adding it officially to the hdaps driver, given that it
> clearly looks like a bogus table in your laptop.

If I am the only one with that entry, it obviously makes more sense that
I apply the patch locally.

> I guess that you only have one laptop with this string?

It's the only thinkpad I have, so yes. I'll ask around on the thinkwiki
mailing list and irc channels

> Can you please check for a BIOS update for your laptop? Maybe that will
> fix the string.

I updated the bios and embedded controller program to the latest
version, and that didn't help. The dmidecode output changed as follows:

--- dmidecode.old       2006-04-01 23:21:46.000000000 +0200
+++ dmidecode.new       2006-04-01 23:21:39.000000000 +0200
@@ -6,8 +6,8 @@
 Handle 0x0000, DMI type 0, 20 bytes
 BIOS Information
        Vendor: IBM
-       Version: 76ET58WW (1.18 )
-       Release Date: 07/19/2005
+       Version: 76ET63WW (1.23 )
+       Release Date: 02/14/2006
        Address: 0xDC000
        Runtime Size: 144 kB
        ROM Size: 1024 kB
@@ -361,7 +361,7 @@
 
 Handle 0x0029, DMI type 11, 5 bytes
 OEM Strings
-       String 1: IBM ThinkPad Embedded Controller -[76HT14WW-1.04    ]-
+       String 1: IBM ThinkPad Embedded Controller -[76HT15WW-1.05    ]-
 
 Handle 0x002A, DMI type 13, 22 bytes
 BIOS Language Information
@@ -516,7 +516,7 @@
 Handle 0x003B, DMI type 134, 13 bytes
 OEM-specific Type
        Header and Data:
-               86 0D 3B 00 0B 00 04 02 0B 00 17 02 0B
+               86 0D 3B 00 02 0B 00 09 02 0B 00 12 02
 
 Handle 0x003C, DMI type 135, 13 bytes
 OEM-specific Type

Frank

> Thanks,
> -- 
> Jean Delvare

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
