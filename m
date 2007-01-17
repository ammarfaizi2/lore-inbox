Return-Path: <linux-kernel-owner+w=401wt.eu-S932584AbXAQS2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbXAQS2n (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 13:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbXAQS2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 13:28:43 -0500
Received: from mx27.mail.ru ([194.67.23.64]:24296 "EHLO mx27.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932584AbXAQS2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 13:28:42 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.20-rc5: BUG: lock held at task exit time! (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170
Date: Wed, 17 Jan 2007 21:28:34 +0300
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0701161515150.2550-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701161515150.2550-100000@iolanthe.rowland.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701172128.38545.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 16 January 2007 23:31, Alan Stern wrote:
> On Tue, 16 Jan 2007, Andrey Borzenkov wrote:
> > I have Toshiba Portege 4000 that almost always hangs dead resuming from
> > STR. This was better before 2.6.18, since then STR is unusable. Sometimes
> > it manages to resume; yesterday I got on console and in dmesg:
> >
> > =====================================
> > [ BUG: lock held at task exit time! ]
> > - -------------------------------------
> > echo/28793 is exiting with locks still held!
> > 1 lock held by echo/28793:
> >  #0:  (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170
> >
> > stack backtrace:
> >  [<c0103fea>] show_trace_log_lvl+0x1a/0x30
> >  [<c01045f2>] show_trace+0x12/0x20
> >  [<c01046a6>] dump_stack+0x16/0x20
> >  [<c0132377>] debug_check_no_locks_held+0x87/0x90
> >  [<c011c8bb>] do_exit+0x4db/0x820
> >  [<c011cc29>] do_group_exit+0x29/0x70
> >  [<c011cc7f>] sys_exit_group+0xf/0x20
> >  [<c010300e>] sysenter_past_esp+0x5f/0x99
> >  =======================
>
> Have you tried using 2.6.19?  There was a bug which got fixed in that
> release.
>

Yes I did. It had the same problem.

Sorry for posting to wrong list, but I hit USB pm_mutex before other one.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFrmrWR6LMutpd94wRAr6eAKCVhFTsgtrrxlPWcY/kCa6hAq8sWACgkUrK
SA8GeytfzwD38IOrVCIkAXU=
=Me0j
-----END PGP SIGNATURE-----
