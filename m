Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVCVGUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVCVGUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVCVGQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:16:16 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:12868 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262275AbVCVGNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:13:37 -0500
Date: Mon, 21 Mar 2005 22:13:36 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.11-rc4: Alps touchpad too slow
Message-ID: <20050322061336.GA2809@hexapodia.org>
References: <20050304221523.GA32685@hexapodia.org> <20050321144412.5e6d9398.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321144412.5e6d9398.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 02:44:12PM -0800, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> > My Vaio r505te comes up with an unusably slow touchpad if I allow the
> > ALPS driver to drive it.  It says
> > 
> > > ALPS Touchpad (Glidepoint) detected
> > >   Disabling hardware tapping
> > > input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> > 
> > and then the trackpad operates at about 1/8 the speed I've gotten used
> > to. ...  2.6.11-rc4 ...
> 
> Andy, could you please test 2.6.12-rc1 and let us know which problems
> remain?

With cvsbk rev 423b66b6oJOGN68OhmSrBFxxLOtIEA (rsynced Monday, it claims
to be "2.6.12-rc1"), the situation is much improved.  The AlpsPS/2
driver recognizes the trackpad, tracking speed is back to normal, and
tapping is turned on by default.  (Drat, now I need to figure out how to
turn that off again.)

The kernel output is a bit odd, though:

[ 1200.254707] Adding 987988k swap on /dev/hda3.  Priority:-1 extents:1
[ 1200.330453] EXT3 FS on hda2, internal journal
[ 1203.504154] SCSI subsystem initialized
[ 1204.039053]   Enabling hardware tapping
[ 1204.099034] ieee1394: Initialized config rom entry `ip1394'
[ 1204.266077] input: PS/2 Mouse on isa0060/serio1
[ 1204.400583] input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
[ 1204.779799] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
[ 1206.183165] kjournald starting.  Commit interval 5 seconds

Note how the "Enabling hardware tapping" message is several lines
earlier than it seems it should be... I don't think I'm supposed to be
tapping on my SCSI hardware.

... ah, I think I'm missing the "ALPS GlidePoint detected" message which
I used to get.  Without it, the "Enabling hardware tapping" message is a
bit opaque.

Other than that, I have no complaints about the trackpad.

Thanks for the ping.

-andy
