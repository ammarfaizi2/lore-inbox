Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318308AbSIKFHj>; Wed, 11 Sep 2002 01:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSIKFHj>; Wed, 11 Sep 2002 01:07:39 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:2311 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318308AbSIKFHi>;
	Wed, 11 Sep 2002 01:07:38 -0400
Date: Wed, 11 Sep 2002 07:12:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pci,hamradio,scsi,aic7xxx,video,zorro clean and mrproper files 4/6
Message-ID: <20020911071219.A1352@mars.ravnborg.org>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org> <20020910230656.D18386@mars.ravnborg.org> <9500000.1031706478@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9500000.1031706478@aslan.btc.adaptec.com>; from gibbs@scsiguy.com on Tue, Sep 10, 2002 at 07:07:58PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 07:07:58PM -0600, Justin T. Gibbs wrote:
> > +# Files generated that shall be removed upon make clean
> > +clean := aic7xxx_seq.h aic7xxx_reg.h
> 
> At lease this line need to be contingent on the actual building of
> firmware.  Otherwise you've just blown away the firmware the vendor
> has shipped with the system and the user may not have the utilities
> to rebuild it.
The original firmware are stored in files named:
aic7xxx_reg.h_shipped  aic7xxx_seq.h_shipped
They are copied to aic7xxx_seq.h aic7xxx_reg.h during the build.
So no problem here.

Snip from original Makefile:
CLEAN_FILES :=
...
        drivers/scsi/aic7xxx/aic7xxx_seq.h \
        drivers/scsi/aic7xxx/aic7xxx_reg.h \
        drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
        drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
        drivers/scsi/aic7xxx/aicasm/y.tab.h \
        drivers/scsi/aic7xxx/aicasm/aicasm \

As you can see the files in question has always been deleted during
a make clean.

The only functional change done is the fact that firmware are now deleted
by make mrproper, as is true for rest of the kernel.

	Sam
