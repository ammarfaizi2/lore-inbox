Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRDFFjH>; Fri, 6 Apr 2001 01:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDFFi6>; Fri, 6 Apr 2001 01:38:58 -0400
Received: from krynn.axis.se ([193.13.178.10]:44202 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S131269AbRDFFip>;
	Fri, 6 Apr 2001 01:38:45 -0400
From: johan.adolfsson@axis.com
Message-ID: <003501c0be5c$224fd5e0$9db270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Erik Mouw" <J.A.K.Mouw@ITS.TUDelft.NL>,
        "Rogier Wolff" <R.E.Wolff@BitWizard.nl>
Cc: "Johan Adolfsson" <johan.adolfsson@axis.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200104052156.XAA02219@cave.bitwizard.nl>
Subject: Re: Arch specific/multiple Configure.help files?
Date: Fri, 6 Apr 2001 07:40:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went ahead and implemented the change last night anyway and I
will submit the patches and see if it will be accepted or not.
The idea is that it first check in arch/$ARCH/Configure.help
and if the file or the help is not found there,
check Documentation/Configure.help.

I believe there is an advantage from a maintenance point of view.
It least for our CRIS architecture, I don't think it's any benefit to
"bloat" the Documentation/Configure.help with a lot of
CONFIG_ETRAX entries for the various hardware inerfaces
when the help and config can be kept locally.

BTW: I added this to scripts/Configure and scripts/Menuconfig
but I know to little tcl/tk to get it to work for the xconfig case.
The variable $ARCH was not found and I don't know how to make
it get it from the environment variables.

/Johan

----- Original Message -----
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Johan Adolfsson <johana@axis.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, April 05, 2001 11:56 PM
Subject: Re: Arch specific/multiple Configure.help files?


> Erik Mouw wrote:
> > On Thu, Apr 05, 2001 at 07:28:33PM +0200, Johan Adolfsson wrote:
> > > Would it be a good idea to have support for multiple Configure.help
> > > files in the config system?
> > > The main advantage would be that arch specific settings could
> > > have an arch specific help file as well.
> >
> > I don't see why this would be an advantage. IMHO Documentation belongs
> > in the Documentation tree and configuration documentation belongs in
> > Configure.help. You almost never read that file yourself, only the
> > various kernel configure tools read it, and tools don't have a problem
> > with large files. It's better to have the documentation at a single
> > point, not scattered around in the kernel tree.
>
> Well, the configure help is now "scattered around": The configuration
> options are in the "configure.in" files, and hte docs for them are
> somewhere else, even if it's in one large file.
>
> I'm not sure if Larry's CML2 has the help for the options near the
> options or not, but that's how I'd like it to be if I were designing
> the thing from scratch. (a bit like emacs' functions: there too, you
> give the help text near the definition of a functions!)
>
> Roger.
>
> --
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
> *-- BitWizard writes Linux device drivers for any device you may have! --*
> * There are old pilots, and there are bold pilots.
> * There are also old, bald pilots.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

