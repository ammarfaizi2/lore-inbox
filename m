Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131419AbRCKNeZ>; Sun, 11 Mar 2001 08:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131420AbRCKNeQ>; Sun, 11 Mar 2001 08:34:16 -0500
Received: from d148.as5200.mesatop.com ([208.164.122.148]:35979 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S131419AbRCKNeF>; Sun, 11 Mar 2001 08:34:05 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Sun, 11 Mar 2001 06:37:10 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Keith Owens <kaos@ocs.com.au>
In-Reply-To: <15167.984293552@ocs3.ocs-net> <3AAB245F.A98004D9@mandrakesoft.com>
In-Reply-To: <3AAB245F.A98004D9@mandrakesoft.com>
Subject: Re: List of recent (2.4.0 to 2.4.2-ac18) CONFIG options needing Configure.help text.
MIME-Version: 1.0
Message-Id: <01031106371001.29664@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 March 2001 00:08, Jeff Garzik wrote:
> Keith Owens wrote:
> > On Sat, 10 Mar 2001 23:03:19 -0700,
> >
> > Steven Cole <elenstev@mesatop.com> wrote:
> > >With the 2.4.0 kernel, there were 476 CONFIG options which had
> > >no help entry in Configure.help.  With 2.4.2-ac18, this number is now
> > > 547, which has been kept this low with 54 options getting
> > > Configure.help text.
> >
> > If any of these CONFIG_ options are always derived (i.e. the user never
> > sees them on a config menu) then please add the suffix _DERIVED to such
> > options.  They still need to start with CONFIG_ to suit the kernel
> > build dependency generator so we cannot change the start of the name.
> > Appending _DERIVED will make it obvious that the options require no
> > help text.
>
> Yow.  That is very cumbersome.  Can't you just keep a list somewhere,
> instead of making such options longer?

BTW, the script I used (originally written by Paul Gortmaker), does pass the
lines in [C,c]onfig.in through grep -v define_ to catch items which are defined
with define_bool or define_int.  Here is a short list of new CONFIG_ items which
got filtered out:

CONFIG_ARCH_S390X
CONFIG_CRIS_LOW_MAP
CONFIG_FBCON_STI
CONFIG_FUSION_BOOT
CONFIG_IP_NF_NAT_FTP
CONFIG_MTD_AMDSTD
CONFIG_PARISC32
CONFIG_SPARC32
CONFIG_SPARC64
CONFIG_TQM8xxL

As far as appending _DERIVED is concerned, I like the idea, but there might be
quite a time where it was only partially implemented, just confusing things.  Unless
those CONFIG_XXX_DERIVED items all got renamed at once like the great redo
300+ Makefiles adventure last fall.

Steven
