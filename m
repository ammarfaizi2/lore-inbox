Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTI3QKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTI3QKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:10:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:64775 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261696AbTI3QK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:10:26 -0400
Date: Tue, 30 Sep 2003 18:10:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andreas Steinmetz <ast@domdv.de>, axboe@suse.de,
       schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930161018.GA900@mars.ravnborg.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Andreas Steinmetz <ast@domdv.de>, axboe@suse.de,
	schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930052337.444fdac4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930052337.444fdac4.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 05:23:37AM -0700, David S. Miller wrote:
> 
> Suggest changes to fix the problems, but just saying "don't include
> kernel header in your user apps, NYAH NYAH NYAH!" does not help
> anyone at all.

I really liked the proposal that Matthew Wilcox came up with:

Todays hirachi:
include/linux		=>	Kernel wide internal
include/sub-system	=>	sub-system internal
include/asm-$(ARCH)	=>	arch specific
include/asm		=>	symlink to include/asm-$(ARCH)
include/asm-generic	=>	default arch implementations

Additional hirachy:
usr/include/linux-abi	=>	kernel wide ABI
usr/include/abi-$(ARCH)	=>	arch specifics ABI
usr/include/arch-abi	=>	symlink to above

I've lost the original email, so the names differ, but the
principle is the same.

Then we could slowly migrate the user level stuff to usr/include.
Do you see this as a sensible solution also for ipv6?

	Sam
