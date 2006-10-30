Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWJ3SoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWJ3SoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbWJ3SoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:44:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58586 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030572AbWJ3SoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:44:13 -0500
Date: Mon, 30 Oct 2006 18:43:31 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
       dm-devel@redhat.com, dm-crypt@saout.de,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Subject: Re: [BUG] dmsetup table output changed from 2.6.18 to 2.6.19-rc3 and breaks yaird.
Message-ID: <20061030184331.GY3928@agk.surrey.redhat.com>
Mail-Followup-To: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	Stefan Schmidt <stefan@datenfreihafen.org>, dm-devel@redhat.com,
	dm-crypt@saout.de, Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
References: <20061030151930.GQ27337@susi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030151930.GQ27337@susi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 04:19:30PM +0100, Stefan Schmidt wrote:
> dmsetup table on 2.6.18 reports: aes-cbc-essiv:sha256
> dmsetup table on 2.6.19-rc3 reports: cbc(aes)-cbc-essiv:sha256

> The problem seems to be on the kernel side here. Herbert Xu changed
> the output with d1806f6a97a536b043fe50e6d8a25b061755cf50
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d1806f6a97a536b043fe50e6d8a25b061755cf50

> The question is if this change was intentional and yaird should be
> fixed, or it's a kernel API breakage.
 
It cannot have been intentional as there was no mention of the change to the
userspace interface in the git changelog (and the interface version number
was not changed).

A new patch is needed to revert the part of the patch that changed the
userspace interface.

Please don't forget to copy in the appropriate maintainers when you send
messages like this one:
  http://marc.theaimsgroup.com/?l=linux-netdev&m=115547174417490&w=2
so they can provide acks:-)

Alasdair
-- 
agk@redhat.com
