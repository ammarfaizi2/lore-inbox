Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTEGOSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTEGOSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:18:45 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:18700 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263208AbTEGOSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:18:44 -0400
Date: Wed, 7 May 2003 16:30:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: george anzinger <george@mvista.com>
Cc: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
       kbuild-devel@lists.sourceforge.net, mec@shout.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic magic
Message-ID: <20030507143059.GA1057@mars.ravnborg.org>
Mail-Followup-To: george anzinger <george@mvista.com>,
	"David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
	kbuild-devel@lists.sourceforge.net, mec@shout.net,
	linux-kernel@vger.kernel.org
References: <3EB75924.1080304@mvista.com> <1052205991.983.13.camel@rth.ninka.net> <3EB817C9.8020603@mvista.com> <20030506.195511.74729679.davem@redhat.com> <3EB8D36E.10206@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB8D36E.10206@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 02:35:42AM -0700, george anzinger wrote:
> If the arch wanted to supply only some of the content, the configure 
> option as is used with some today, is still available.  CURRENT USAGE 
> IS NOT AFFECTED.

The usage of magic symlinks shall be kept minimal. 
The asm -> $(ARCH)-asm symlink already has caused me troubles when
doing cross compilation. Also the separate obj tree patch treats
the symlink with special care.

the gain should be high introducing one more symlink.
For what I understood the gain is only to avoid a couple of
one line files that inculde another file. Not enough to justify a 
second symlink IMHO.

	Sam
