Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVCAO20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVCAO20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCAO2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:28:25 -0500
Received: from news.suse.de ([195.135.220.2]:22992 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261908AbVCAO2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:28:21 -0500
Date: Tue, 1 Mar 2005 15:28:19 +0100
From: Michael Schroeder <mls@suse.de>
To: Michal Januszewski <spock@gentoo.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050301142819.GA23884@suse.de>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050228174015.GB1349@elf.ucw.cz> <20050301130325.GB14278@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301130325.GB14278@spock.one.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 02:03:25PM +0100, Michal Januszewski wrote:
> Possibly, but I can't recall what exactly was it about. All bugs in
> fbsplash, that I have known of, have been fixed. If there are still some
> problems with any fb drivers, please let me know.

Well, you'll run into trouble with all drivers that use a non-standard
fb_imageblit, i.e.:

amifb
cirrusfb
cyber2000fb
hgafb
neofb
tdfxfb
tgafb
vga16fb
atyfb
radeon_accel
i810
intelfb
matroxfb_accel
riva
savage

Hmm, maybe I should change the vesafb test in the bootsplash code
to test if fb_imageblit == cfb_imageblit. This would make Pavel
very happy, I guess ;-)

Cheers,
  Michael.

-- 
Michael Schroeder                                   mls@suse.de
main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
