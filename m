Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTJVQWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbTJVQWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 12:22:53 -0400
Received: from borg.org ([64.105.205.123]:24106 "HELO borg.org")
	by vger.kernel.org with SMTP id S263435AbTJVQWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 12:22:52 -0400
Date: Wed, 22 Oct 2003 12:22:51 -0400
From: Kent Borg <kentborg-rhl@borg.org>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031022122251.A3921@borg.org>
References: <3F8E552B.3010507@users.sf.net> <bn40oa$i4q$1@gatekeeper.tmr.com> <bn46q9$1rv$1@cesium.transmeta.com> <bn4aov$jf7$1@gatekeeper.tmr.com> <bn4l5q$v73$1@cesium.transmeta.com> <20031022025602.GH17713@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031022025602.GH17713@pegasys.ws>; from jw@pegasys.ws on Tue, Oct 21, 2003 at 07:56:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 07:56:02PM -0700, jw schultz wrote:
> I am curious how someone is going to use random data from a device
> in a shell

I regularly use:

  $ head -c 4 /dev/random | ./mnencode

I do it when I need to generate yet another password (I finally had
the brains to realize I can't reuse passwords).  I pipe 4 (rarely
more) bytes into mnencode, a cute little program that maps any data
into pronounceable/spellable words.  (And mndecode will reverse to
process.)  So I have a lot of passwords that look like
corona-million-binary or horizon-july-egypt or single-august-pump
or...

For more information on mnencode see
<http://www.tothink.com/mnemonic/>.


-kb, the Kent who would like to see the kernel's random number
generator improved (better entropy estimation, better entropy
management, ability to supply some initial entropy early in the
boot--for embedded devices--and even speed), but the Kent who doesn't
want the kernel to be exploded into a catalogue of competing random
number generators.


P.S.  When is there going to be a good open source password safe for
Palm OS?
