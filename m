Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbVLODqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbVLODqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbVLODqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:46:52 -0500
Received: from femail.waymark.net ([206.176.148.84]:36567 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1161020AbVLODqv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:46:51 -0500
Date: 15 Dec 2005 03:37:42 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [SERIAL, -mm] CRC failure
To: linux-kernel@vger.kernel.org
In-Reply-To: <1134574264.25663.38.camel@localhost.localdomain>
Message-ID: <603f0b.8eacb5@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In article 14 Dec 05  15:31:04, alan@lxorguk.ukuu.org.uk wrote to Kenneth
Parrish <=-

 al> Ok so a fairly slow old VIA box with slow processor. Still ought
 al> to be fast enough in the normal case not to drop characters.
gcc 3.4.5 takes nine hours to compile. not bad.
yes serial has been okay, it seems; and for some time, switching
from X window to console and back during file transfers is OK now..
almost always got crc errors in past years doin that.

 al> Try this and let me know what effect it has. Also I'd be
 al> interested to know if you see the problem in X or both in X and
 al> console mode.
(patch snipped)
Thanks, i typed it in by hand cause there was e-mail damage -- tried to
repair it using vim with line endings and tabs displayed, but didn't fix
it well enough for 'patch'.
no errors during the compile, and alas no change noticeable. i
uncommented the /var/log/debug option in /etc/syslog.conf and restarted
syslogd/klogd from /etc/rc.d/rc.syslog (slackware v10.0 of about a year
and a hlaf back), but nothing.
might enabling one or more of the kernel debugging options help? I can
do so and retest, and try another patch.
I only use minicom from the console and haven't made the effort to get
it to work in both X and console with keyboard and character display
correct (may not be too hard;).

m is aliased to `echo -en "\033(U";minicom;echo -en "\033(B"'
and this also from ~/.bash_profile after 'tic'ing the minicom
terminfo entry supplied with minicom.

         case "$TERM" in
           con*|linux)
                 MINICOM="-l -m -con -tmc" ; export MINICOM
                 ;;
         esac

--- MultiMail/Linux v0.46
