Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbRCPKz1>; Fri, 16 Mar 2001 05:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRCPKzQ>; Fri, 16 Mar 2001 05:55:16 -0500
Received: from imladris.infradead.org ([194.205.184.45]:65033 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S130442AbRCPKzE>;
	Fri, 16 Mar 2001 05:55:04 -0500
Date: Fri, 16 Mar 2001 10:54:13 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: <Andries.Brouwer@cwi.nl>
cc: <kaboom@gatech.edu>, <linux-kernel@vger.kernel.org>,
        <seberino@spawar.navy.mil>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <UTC200103141929.UAA178418.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0103161035180.20436-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries.

 > [Yes, I wrote, replying to your mail, just because I happened to
 > notice the incorrect or debatable lines in your patch. Let me cc
 > the Changes maintainer - maybe Chris Ricker.]

 >>>> -o  util-linux             2.10o                   # fdformat --version
 >>>> +o  util-linux         #   2.10o        # fdformat --version

 >>> Looking at fdformat to get the util-linux version is perhaps not
 >>> the most reliable way - some people have fdformat from elsewhere.
 >>> Using mount --version would be better - I am not aware of any
 >>> other mount distribution.

 >> RedHat distribute mount separately from util-linux and I
 >> wouldnae be surprised if others do the same...

 > I am not aware of any distribution that ships some version of
 > util-linux, but replaces its mount part by an older version. I
 > think that even in cases where, because of historical reasons,
 > util-linux is repackaged in several parts, mount --version gives
 > the right answer.

Neither am I - but, according to comments from RedHat a while back,
they repackage mount separately because they provide a NEWER version
of mount than is in the util-linux package. This will ALSO result in
`mount --version` giving the wrong answer...

 >>>> +In addition, it is wise to ensure that the following packages are
 >>>> +at least at the versions suggested below, although these may not
 >>>> +be required, depending on the exact configuration of your system:
 >>>> +
 >>>> +o  Console Tools      #   0.3.3        # loadkeys -V
 >>>> +o  Mount              #   2.10e        # mount --version

 >>> Concerning mount:
 >>>
 >>> (i) the version mentioned is too old,

 >> As stated in my original post, I've no idea what the correct
 >> version should be as it's not documented anywhere I can find.

 >>> (ii) mount is in util-linux.

 >> Not on RedHat systems.

 > There is no other source. Some people like to repack but that
 > has no influence on versions.

Unless one can guarantee that the util-linux and mount packages are
the SAME version, mount can't be guaranteed to report the version of
the util-linux package installed. RedHat provide a NEWER version of
mount to util-linux so that guarantee doesnae exist.

 >>> Conclusion: the mount line should be deleted entirely.

Conclusion: Both the mount and util-linux lines are REQUIRED.

 >>> Concerning Console Tools: maybe kbd-1.05 is uniformly better.
 >>> I am not aware of any reason to recommend the use of
 >>> console-tools.

 >> Neither am I. The ver_linux script has lines for determining the
 >> versions for both Console Tools and Kbd but on EVERY system I've
 >> tried, including Slackware, RedHat, Debian, Caldera, and SuSE
 >> based ones, the line for determining Kbd versiondoesnae work.
 >> I've just included the line that worked, and ignored the Kbd one
 >> as I can see no point including something that doesnae work.

 > You are mistaken, as is proved by the reports that contain a kbd
 > line: a grep on linux-kernel for this Februari shows people with
 > Kbd 0.96, 0.99 and 1.02.

{Shrug} Please explain why I was unable to get ver_linux to report a
kbd line on ANY of the systems I tried, including systems with it
definately installed. I tried it out manually on several such systems,
and ALL reported the SAME error message to the `loadkeys -h` command
used in scripts/ver_linux which is:

 Q> $ loadkeys -h 2>&1 > x
 Q> Usage: loadkeys [option...] [mapfile...]
 Q> valid options are:
 Q>   -c --clearcompose clear kernel compose table
 Q>   -d --default      load default keymap file
 Q>   -m --mktable      output a "defkeymap.c" to stdout
 Q>   -s --clearstrings clear kernel string table
 Q>   -q --quiet        be silent
 Q>   -v --verbose      report the changes
 Q>   -v --verbose      report more changes
 Q>   -h --help         display this help text and exit
 Q>   -V --version      display version information and exit
 Q> $

Also, please advise where the version number is in that text...

Best wishes from Riley.

