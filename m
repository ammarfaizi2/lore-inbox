Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315626AbSECKme>; Fri, 3 May 2002 06:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSECKmd>; Fri, 3 May 2002 06:42:33 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:57865 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315626AbSECKmd>;
	Fri, 3 May 2002 06:42:33 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "03 May 2002 10:06:04 GMT."
             <slrnad4o8c.hbt.kraxel@bytesex.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 20:42:04 +1000
Message-ID: <11028.1020422524@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2002 10:06:04 GMT, 
Gerd Knorr <kraxel@bytesex.org> wrote:
>>  Do it with NO_MAKEFILE_GEN=1 for much, much! faster builds.
>
>What exactly is the reason for this hack, i.e. why kbuild wants to
>rebuild the Makefiles every time?  Isn't it enougth to do that only
>if .config has been touched?

Or any of the Makefile.in files have changed.  Or any of the command
line options have changed.  Or various environment variables have
changed.  Or a target file has been altered outside kbuild control.
Or the compiler has changed.  Or ... the list goes on.

Coding a special case to work out if the existing global makefile can
be reused is horribly error prone.  And it would take just as long as
rebuilding the global makefile from scratch.

