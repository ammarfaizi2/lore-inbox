Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTHYKl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbTHYKl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:41:57 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:28862
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261665AbTHYKll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:41:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 20:48:38 +1000
User-Agent: KMail/1.5.3
References: <200308231555.24530.kernel@kolivas.org> <20030825094240.GJ16080@Synopsys.COM> <yw1xad9yca8j.fsf@users.sourceforge.net>
In-Reply-To: <yw1xad9yca8j.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308252048.38562.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003 20:17, Måns Rullgård wrote:
> Alex Riesen <alexander.riesen@synopsys.COM> writes:
> >> XEmacs still spins after running a background job like make or grep.
> >> It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
> >> as often, or as long time as with O16.3, but it's there and it's
> >> irritating.
> >
> > another example is RXVT (an X terminal emulator). Starts spinnig after
> > it's child has exited. Not always, but annoyingly often. System is
> > almost locked while it spins (calling select).
>
> It sounds like the same bug.  IMHO, it's rather bad, since a
> non-privileged process can make the system unusable for a non-zero
> amount of time.
>
> How should I do to capture some information about this thing?  Do you
> know what causes it, Con?

Read my rfc on the orthogonal interactivity patches and look under priority 
inversion. It may be that, in which case it happens to vanilla as well. To 
capture useful information for me is quite easy. Run a reniced -11 top -d 1 
-b in batch mode and reniced -11 vmstat 1 in batch mode to capture it 
happening. That should be enough information to see what's going on and 
doesn't need a kernel compile or any special tools. Renice -11 to make sure 
the tools dont get preempted in that period.

Con

