Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272667AbRIVDAX>; Fri, 21 Sep 2001 23:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272681AbRIVDAN>; Fri, 21 Sep 2001 23:00:13 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:37136 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S272667AbRIVDAK>;
	Fri, 21 Sep 2001 23:00:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Crutcher Dunnavant <crutcher@datastacks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens) 
In-Reply-To: Your message of "Fri, 21 Sep 2001 15:58:06 -0400."
             <20010921155806.B8188@mueller.datastacks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Sep 2001 12:59:20 +1000
Message-ID: <17588.1001127560@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001 15:58:06 -0400, 
Crutcher Dunnavant <crutcher@datastacks.com> wrote:
>A cleaner handling of module parameters/cmd line options.

That comes out as a side effect of kernel build 2.5, every object gets
-DKBUILD_OBJECT to define the name it is known by.  From
Documentation/kbuild/kbuild-2.5.

      -DKBUILD_OBJECT=module, the name of the module the object is
        linked into, without the trailing '.o' and without any paths.
        If the object is a free standing module or is linked into
        vmlinux then the "module" name is the object itself.
        Automatically generated.

Post kbuild 2.5 I will be writing a generic parameter/command line
interface so you can insmod foo bar=99 or boot with foo.bar=99.  You
will even be able to boot with foo.bar=99 when foo is a module, insmod
will use the command line as a default set of values.

