Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315622AbSECKI6>; Fri, 3 May 2002 06:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315623AbSECKI6>; Fri, 3 May 2002 06:08:58 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:60168 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315622AbSECKI5>;
	Fri, 3 May 2002 06:08:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Nick Sanders <sandersn@btinternet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.3 is available 
In-Reply-To: Your message of "Fri, 03 May 2002 10:18:47 +0100."
             <200205031018.47907.sandersn@btinternet.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 20:08:41 +1000
Message-ID: <10849.1020420521@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002 10:18:47 +0100, 
Nick Sanders <sandersn@btinternet.com> wrote:
>On Friday 03 May 2002 9:51 am, Keith Owens wrote:
>> Sigh.  Silly error in the fix :(
>>
>> cd $KBUILD_SRCTREE_000
>> perl -i -ple 's/\(CC\)/(CC_real)/g;' arch/i386/Makefile.defs.*config
>
>The 1st fix worked fine for me, thanks

Only by accident.  If you used CONFIG_MK6 or CONFIG_MK7 with a version
of gcc that did not understand -march=k6 or -march=athlon then it would
have failed.  $(CC_real) is the correct fix.

