Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbRLVIOY>; Sat, 22 Dec 2001 03:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286713AbRLVIOH>; Sat, 22 Dec 2001 03:14:07 -0500
Received: from femail34.sdc1.sfba.home.com ([24.254.60.24]:15353 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S286712AbRLVINq>; Sat, 22 Dec 2001 03:13:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com, David Garfield <garfield@irving.iisd.sra.com>
Subject: Re: Configure.help editorial policy
Date: Fri, 21 Dec 2001 19:12:13 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <15395.33489.779730.767039@irving.iisd.sra.com> <20011221134034.B11147@thyrsus.com>
In-Reply-To: <20011221134034.B11147@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011222081345.ETGO12125.femail34.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 December 2001 01:40 pm, Eric S. Raymond wrote:
> David Garfield <garfield@irving.iisd.sra.com>:
> > Eric S. Raymond writes:

> > Choice of kB vs KB vs KiB vs KKB could also be used in some places in
> > the kernel.  For instance, /proc/meminfo currently shows "kB".
>
> What, and *encourage* non-uniform terminology?  No, I won't do that.
> Better to have a single standard set of abbreviations, no matter how
> ugly, than this.

 find . -name "*.?" | xargs grep MiB | wc
     46 lines, half of which seem to live in "jedec_probe.c".

 find . -name "*.?" | xargs grep -w MB | wc
    302 lines.  And that's just upper case, whole word, not "MBs" or "Mb" or 
any other fun little variation...

 find . -name "*.?" | xargs grep -i MEGABYTE | wc
     31 lines.

 find . -name "*.?" | xargs grep -i MEBIBYTE | wc
      1 line, and it's a comment saying it's NOT being used (along with one 
of the MiB hits).

If you're going with a uniform terminology argument, you should drop MiB 
altogether.  Unless you want to submit a patch to the kernel to standardize 
all the other occurences everywhere else? :)

Rob
