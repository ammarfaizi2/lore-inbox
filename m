Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265483AbUFCDpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbUFCDpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 23:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265486AbUFCDpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 23:45:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265483AbUFCDpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 23:45:43 -0400
Message-ID: <40BE9ED8.9020505@pobox.com>
Date: Wed, 02 Jun 2004 23:45:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, jkmaline@cc.hut.fi,
       James P Ketrenos <james.p.ketrenos@intel.com>
Subject: wireless-2.6 queue opened
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's high time that Linux get a serious effort going on a generic 802.11 
stack, as it seems we are in danger of having every new wireless driver 
invent one if we do not.

Given that there are at least 3 complete wireless stacks (or 
thereabouts) floating about for Linux, I picked one that I felt had the 
best chance of being _evolved_ into a nice, clean, generic wireless 
stack:  HostAP.

My general hope (plan?) is that generic wireless code can be arrived at 
without horribly intrusive changes that require a 2.7 kernel. 
wireless-2.6 is targetted for eventual merging, but it won't be 
submitted anytime soon.

Now it's time for open source to kick into action :)  wireless-2.6 queue 
is available in patch form or BitKeeper for review.  Or, if you object 
to my selection of wireless code, now's the time to speak up.

BTW to Intel Centrino folks -- I would like to merge the current (open 
source) Centrino driver into wireless-2.6 as well, to get it more 
exposure, and also to ensure that it uses whatever generic 802.11 code 
happens to appear...

Oh, and please speak up on netdev@oss.sgi.com, or at least CC there.

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.7-rc2-bk3-wireless1.patch.bz2

BitKeeper (all of these are equivalent):
bk://kernel.bkbits.net/jgarzik/wireless-2.6
bk://gkernel.bkbits.net/wireless-2.6
http://gkernel.bkbits.net/wireless-2.6 (note: _not_ a Web URL)




Finally, here is Jouni's patch submission message, elaborating on the 
driver-specific details:
> Finally, here's the first attempt at submitting Host AP code for
> wireless-2.6 tree. In addition, this could be considered for merging
> into linus-2.5 tree, so review and comments are very much welcome. Host
> AP code has lived in an external CVS repository for three years and is
> widely used.
> 
> The included patch has minimal changes to the current tree (against
> 2.6.6, but should apply to different versions with some differences in
> line numbers) for including a new directory drivers/net/wireless/hostap.
> The contents of that new directory is a bit large for a patch file and
> since all the files are new, I made it available as a compressed tarball
> at http://hostap.epitest.fi/hostap-linux.tgz. This should be untarred in
> the root of the kernel tree (i.e., the file paths in the tarball start
> with drivers/net/wirelss/hostap/...).
> 
> I removed most of the backwards (for Linux 2.4, pcmcia-cs modules,
> different wireless extensions versions) compatibility code. In addition,
> I replaced integrated implementations of ARC4, Michael MIC, and AES with
> crypto API. AES-CCM mode is still implemented in hostap_crypt_ccmp.c,
> but it could be moved at some point to crypto API as a new encryption
> mode.


