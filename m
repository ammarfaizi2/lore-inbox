Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314035AbSDKMma>; Thu, 11 Apr 2002 08:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314038AbSDKMm3>; Thu, 11 Apr 2002 08:42:29 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:56586 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314035AbSDKMm3>; Thu, 11 Apr 2002 08:42:29 -0400
Date: Thu, 11 Apr 2002 14:42:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: <10197.1018483487@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.21.0204111439550.25032-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Apr 2002, Keith Owens wrote:

> There can be multiple destination files, e.g. running yacc produces a
> .c and a .h file.

The checksum only needs to be stored in one of them.

> The generated file is not necessarily .[ch], wrapping the md5sum in
> /* */ may break some generated files.  AFAIK all currently generated
> files are .[ch] but I do not want to restrict future builds.

The wrapping could be changed with an argument and if everything fails,
the checksum can still be put into a separate file.

> The output can change without the inputs changing.  For example, the
> distributor might find a bug in the tool that generates the file,
> install a new version of the tool and regenerate.  The inputs have not
> changed but the output has.  To detect this, the md5sum is across all
> files, including the outputs, which makes it impossible to store the
> sum in one of the output files.

What exactly are you detecting? Simply regenerate the files and distribute
the changes, the checksum won't change, but I don't understand how that
should matter.
What other problem are you trying to solve? My simple script solves the
problem of unreliable time stamps, when applying patches. Unless the user
changes the inputs, the output files won't be regenerated.

bye, Roman

