Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290345AbSAPEEz>; Tue, 15 Jan 2002 23:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290346AbSAPEEp>; Tue, 15 Jan 2002 23:04:45 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:34945
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290345AbSAPEEg>; Tue, 15 Jan 2002 23:04:36 -0500
Date: Tue, 15 Jan 2002 22:48:21 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rob Landley <landley@trommello.org>
Cc: Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020115224821.A4658@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rob Landley <landley@trommello.org>, Nicolas Pitre <nico@cam.org>,
	lkml <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0201151538340.5892-100000@xanadu.home> <20020116034137.CRFB26021.femail12.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116034137.CRFB26021.femail12.sdc1.sfba.home.com@there>; from landley@trommello.org on Tue, Jan 15, 2002 at 02:19:07PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org>:
> I -STILL- can't figure out why the autoprober doesn't just look in 
> /proc/mounts to figure out who and what our root device and filesystem are.

The version I just released does exactly that.  Well, not exactly; it
actually looks at fstab -- /proc/mounts gives you '/dev/root' rather
than a physical device name in the root entry.
 
> I need to set up a system that boots to an initrd and puts the root
> device lives on a samba server just to confuse eric's autoprober.
> Hmmm...  I wonder if that would work? :)

No.  It only knows about IDE and SCSI root devices at the moment.  As I 
learn how to identify other kinds of root volume it will get smarter.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The IRS has become morally corrupted by the enormous power which we in
Congress have unwisely entrusted to it. Too often it acts like a
Gestapo preying upon defenseless citizens.
	-- Senator Edward V. Long
