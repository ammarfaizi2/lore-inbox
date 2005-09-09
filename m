Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVIIPmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVIIPmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVIIPmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:42:51 -0400
Received: from relay4.mail.ox.ac.uk ([129.67.1.163]:8143 "EHLO
	relay4.mail.ox.ac.uk") by vger.kernel.org with ESMTP
	id S964972AbVIIPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:42:50 -0400
Date: Fri, 9 Sep 2005 16:42:47 +0100
From: Ian Collier <Ian.Collier@comlab.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: loop ioctl crashes
Message-ID: <20050909164246.B23692@pixie.comlab>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050909132725.C23462@pixie.comlab> <Pine.LNX.4.61.0509090829260.8368@chaos.analogic.com> <20050909143804.A23692@pixie.comlab> <Pine.LNX.4.61.0509091017020.4550@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0509091017020.4550@chaos.analogic.com>; from linux-os@analogic.com on Fri, Sep 09, 2005 at 10:41:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 10:41:29AM -0400, linux-os (Dick Johnson) wrote:
> Try to see if it is really the loop device or something that is
> interfacing with it. Here I copy the contents of a DOS floppy
> to a file, then mount the file through the loop device:

I do know how to use loop devices. ;-)

Now you mention it, "losetup" without encryption works fine.

This: losetup -e blowfish /dev/loop0 /tmp/test.img
fails with "bad address" if the blowfish module is not loaded,
and causes a kernel panic if it is (and now I have to go home
to reset my machine. :-( ).

The only thing I can see that the ppdd patch has done here is to
increase LO_KEY_SIZE from 32 to 1844; the rest should be as in
vanilla 2.6.13 (though at some point I'll recompile without
patches and see if that changes anything).

imc
